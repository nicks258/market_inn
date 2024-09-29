// data/repositories/websocket_repository_impl.dart
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../core/data/error/failures.dart';

import '../../domain/entities/price.dart';
import '../../domain/repositories/websocket_repository.dart';
import '../datasources/rest_api_data_source.dart';
import '../datasources/websocket_remote_data_source.dart';

class PriceRepositoryImpl implements PriceRepository {
  final WebSocketRemoteDataSource webSocketRemoteDataSource;
  final RestApiDataSource restApiDataSource;

  PriceRepositoryImpl(
      this.webSocketRemoteDataSource, this.restApiDataSource) {
    _startMonitoring();
  }

  // Map to store the last received WebSocket timestamp for each symbol
  final Map<String, DateTime> _lastReceivedData = {};

  // Periodic timer to check for missing data
  Timer? _monitoringTimer;
  Duration monitorTime = Duration(seconds: 5);

  final Map<String, Timer> _symbolTimers = {};
  final Duration noDataTimeout = Duration(seconds: 10);

  @override
  Stream<Either<Failure, Price>> getPriceStream(String symbol) async* {
    try {
      final webSocketStream = webSocketRemoteDataSource.getPriceStream(symbol);

      _lastReceivedData[symbol] = DateTime.now();
      await for (final price in webSocketStream) {
        // Update the last received timestamp when data is received
        _lastReceivedData[price.symbol] = DateTime.now();
        yield Right(price);
      }
    } on WebSocketChannelException catch (e) {
      debugPrint('WebSocket error in repository: $e');
      yield Left(
          ServerFailure()); // Yield a failure if WebSocket connection fails
    } catch (e) {
      yield Left(ServerFailure()); // Catch any other exception
    }
  }

  @override
  Future<Price?> getLatestPriceFromApi(String symbol) async {
    try {
      final price = await restApiDataSource.fetchLatestPrice(symbol);
      debugPrint('Fetched latest price from REST API for $symbol: $price');
      return price;
    } catch (e) {
      debugPrint('Failed to fetch price for $symbol from REST API: $e');
      return null;
    }
  }


  void _startMonitoring() {
    _monitoringTimer = Timer.periodic(monitorTime, (timer) async {
      final now = DateTime.now();
      for (var symbol in _lastReceivedData.keys) {
        final lastDataTime = _lastReceivedData[symbol];
        if (lastDataTime != null &&
            now.difference(lastDataTime) > noDataTimeout) {
          debugPrint(
              'No WebSocket data received for $symbol. Triggering fallback API...');
          timer.cancel();
          monitorTime = Duration(minutes: 5);
          _startMonitoring();
          debugPrint('cancelling timer');
          // Call REST API to fetch the latest price for the symbol
          final latestPrice = await getLatestPriceFromApi(symbol);
          if (latestPrice != null) {
            webSocketRemoteDataSource.addManualPrice(latestPrice);
          }
          // Reset the last received time after fetching from REST API
          _lastReceivedData[symbol] = DateTime.now();
        }
      }
    });
  }

  // Ensure that all timers are cleared when no longer needed
  @override
  void dispose() {
    _monitoringTimer?.cancel();
  }
}
