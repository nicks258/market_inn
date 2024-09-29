import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../../domain/entities/price.dart';

class WebSocketRemoteDataSource {
  final String apiKey;
  late WebSocketChannel _channel;
  late StreamController<Price> _controller;
  final List<String> _subscribedSymbols = [];
  bool _isConnected = false;
  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 5;

  WebSocketRemoteDataSource({required this.apiKey}) {
    _controller = StreamController<Price>.broadcast();
    _connect();
  }

  void _connect() {
    debugPrint("Attempting WebSocket connection...");

    try {
      // Establish WebSocket connection
      _channel = WebSocketChannel.connect(
        Uri.parse('wss://ws.finnhub.io?token=$apiKey'),
      );
      _isConnected = true;
      _reconnectAttempts = 0; // Reset attempts upon successful connection
      debugPrint('WebSocket connected.');

      // Listen to WebSocket messages
      _channel.stream.listen(
            (data) {
          final decodedData = jsonDecode(data);

          if (!_controller.isClosed && decodedData['type'] == 'trade') {
            final price = Price(
              symbol: decodedData['data'][0]['s'],
              value: decodedData['data'][0]['p'] + .0,
            );
            _controller.add(price);
          }
        },
        onError: (error) {
          _handleError('WebSocket Error: $error');
        },
        onDone: () {
          _handleError('WebSocket connection closed.');
        },
        cancelOnError: true, // Automatically cancel the stream on error
      );

      // Resubscribe to previously subscribed symbols
      _resubscribeSymbols();
    } on WebSocketException catch (e) {
      _handleError('WebSocketException: $e');
    } on SocketException catch (e) {
      _handleError('SocketException: $e');
    } catch (e) {
      _handleError('Unknown error occurred: $e');
    }
  }

  /// Handles errors and triggers reconnection logic
  void _handleError(String message) {
    debugPrint(message);
    _isConnected = false;

    if (_reconnectAttempts < _maxReconnectAttempts) {
      _reconnect();
    } else {
      debugPrint('Max reconnection attempts reached. Giving up.');
    }
  }

  /// Attempts reconnection with exponential backoff
  void _reconnect() {
    _reconnectAttempts += 1;
    final delay = Duration(minutes: 1 * _reconnectAttempts);
    debugPrint('Reconnecting in ${delay.inSeconds} seconds (Attempt $_reconnectAttempts)');

    Future.delayed(delay, () {
      if (!_isConnected && _reconnectAttempts < _maxReconnectAttempts) {
        _connect();
      }
    });
  }

  /// Resubscribe to symbols after reconnection
  void _resubscribeSymbols() {
    for (var symbol in _subscribedSymbols) {
      _channel.sink.add(jsonEncode({'type': 'subscribe', 'symbol': symbol}));
    }
    debugPrint('Resubscribed to symbols: $_subscribedSymbols');
  }

  /// Stream for a specific symbol's price updates
  Stream<Price> getPriceStream(String symbol) async* {
    if (!_subscribedSymbols.contains(symbol)) {
      _subscribedSymbols.add(symbol);
      if (_isConnected) {
        _channel.sink.add(jsonEncode({'type': 'subscribe', 'symbol': symbol}));
      } else {
        debugPrint("WebSocket not connected, cannot subscribe.");
      }
    }
    yield* _controller.stream;
  }

  void addManualPrice(Price price) {
    if (!_controller.isClosed) {
      debugPrint('Manual price added for ${price.symbol}: ${price.value}');
      _controller.add(price);
    }
  }

  /// Unsubscribe from a specific symbol's updates
  void unsubscribe(String symbol) {
    _subscribedSymbols.remove(symbol);
    if (_isConnected) {
      _channel.sink.add(jsonEncode({'type': 'unsubscribe', 'symbol': symbol}));
    }
  }

  /// Close WebSocket connection and stream
  void close() {
    _isConnected = false;
    _channel.sink.close(status.normalClosure);
    _controller.close();
    debugPrint('WebSocket and stream closed.');
  }
}
