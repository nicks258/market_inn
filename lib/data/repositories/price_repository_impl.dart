// data/repositories/price_repository_impl.dart
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:market_inn/core/resources/app_constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/data/error/failures.dart';
import '../../domain/entities/price.dart';
import '../../domain/repositories/price_repository.dart';
import '../datasources/rest_api_data_source.dart';
import '../datasources/websocket_remote_data_source.dart';

class PriceRepositoryImpl implements PriceRepository {
  final WebSocketRemoteDataSource webSocketRemoteDataSource;
  final RestApiDataSource restApiDataSource;
  final Function(Duration, void Function(Timer)) timerCreator;

  PriceRepositoryImpl(this.webSocketRemoteDataSource, this.restApiDataSource,
      {this.timerCreator = Timer.periodic}) {
    _startMonitoring();
  }

  // Map to store the last received WebSocket timestamp for each symbol
  late final Map<String, DateTime> _lastReceivedData = {};

  // Periodic timer to check for missing data
  Timer? _monitoringTimer;
  Duration monitorTime = Duration(seconds: 5);



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

      yield Left(ServerFailure(
          "Something went wrong :${e.message}")); // Yield a failure if WebSocket connection fails
    } catch (e) {
      yield Left(ServerFailure(
          "Something went wrong :${e.toString()}")); // Catch any other exception
    }
  }

  @override
  Future<Either<Failure, Price>> getLatestPriceFromApi(String symbol) async {
    try {
      final price = await restApiDataSource.fetchLatestPrice(symbol);

      return Right(price);
    } on SymbolNotFoundFailure catch (e) {
      return Left(SymbolNotFoundFailure(e.message));
    } catch (e) {

      return Left(ServerFailure("Something went wrong :${e.toString()}"));
    }
  }

  void _startMonitoring() {
    _monitoringTimer = timerCreator(monitorTime, (timer) async {
      final now = DateTime.now();
      for (var symbol in _lastReceivedData.keys) {
        final lastDataTime = _lastReceivedData[symbol];
        if (lastDataTime != null &&
            now.difference(lastDataTime) > AppConstants.noDataTimeout) {

          timer.cancel();
          monitorTime = Duration(minutes: 5);
          _startMonitoring();

          // Call REST API to fetch the latest price for the symbol
          final latestPrice = await getLatestPriceFromApi(symbol);
          latestPrice.fold(
            (l) {
              webSocketRemoteDataSource.addManualPrice(symbol: symbol);
            },
            (r) {
              webSocketRemoteDataSource.addManualPrice(
                  price: r, symbol: r.symbol);
            },
          );

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
