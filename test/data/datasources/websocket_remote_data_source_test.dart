// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:market_inn/data/datasources/websocket_remote_data_source.dart';
// import 'package:market_inn/domain/entities/price.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
// class MockWebSocketChannel extends Mock implements WebSocketChannel {}
// class MockWebSocketSink extends Mock implements WebSocketSink {}
//
// void main() {
//   late WebSocketRemoteDataSource dataSource;
//   late MockWebSocketChannel mockChannel;
//   late MockWebSocketSink mockSink;
//   late StreamController<dynamic> streamController;
//
//   setUpAll(() {
//     registerFallbackValue(Uri.parse('wss://example.com'));
//   });
//
//   setUp(() {
//     mockChannel = MockWebSocketChannel();
//     mockSink = MockWebSocketSink();
//     streamController = StreamController<dynamic>.broadcast();
//
//     when(() => mockChannel.sink).thenReturn(mockSink);
//     when(() => mockChannel.stream).thenAnswer((_) => streamController.stream);
//
//     // dataSource = WebSocketRemoteDataSource(channel: mockChannel);
//   });
//
//   tearDown(() {
//     streamController.close();
//     dataSource.close();
//   });
//
//   test('getPriceStream should subscribe to a symbol', () async {
//     const symbol = 'AAPL';
//     dataSource.getPriceStream(symbol);
//
//     verify(() => mockSink.add(jsonEncode({'type': 'subscribe', 'symbol': symbol})));
//   });
//
//   test('getPriceStream should emit prices for subscribed symbol', () async {
//     const symbol = 'AAPL';
//     final stream = dataSource.getPriceStream(symbol);
//
//     streamController.add(jsonEncode({
//       'type': 'trade',
//       'data': [{'s': symbol, 'p': 150.0}]
//     }));
//
//     expect(
//       stream,
//       emits(Price(symbol: symbol, value: 150.0)),
//     );
//   });
//
//   test('unsubscribe should remove symbol and send unsubscribe message', () {
//     const symbol = 'AAPL';
//     dataSource.getPriceStream(symbol);
//     dataSource.unsubscribe(symbol);
//
//     verify(() => mockSink.add(jsonEncode({'type': 'unsubscribe', 'symbol': symbol})));
//   });
//
//   test('addManualPrice should emit a price', () async {
//     const symbol = 'AAPL';
//     final price = Price(symbol: symbol, value: 160.0);
//
//     final stream = dataSource.getPriceStream(symbol);
//     dataSource.addManualPrice(price);
//
//     expect(stream, emits(price));
//   });
//
//   test('close should close the channel and controller', () {
//     dataSource.close();
//
//     verify(() => mockSink.close(any()));
//   });
//
//   test('resubscribeSymbols should resubscribe to all symbols', () {
//     const symbols = ['AAPL', 'GOOGL'];
//     for (final symbol in symbols) {
//       dataSource.getPriceStream(symbol);
//     }
//
//     dataSource.resubscribeSymbols();
//
//     for (final symbol in symbols) {
//       verify(() => mockSink.add(jsonEncode({'type': 'subscribe', 'symbol': symbol})));
//     }
//   });
// }
