import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/data/repositories/price_repository_impl.dart';
import 'package:market_inn/domain/entities/price.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/data/mock_rest_api_data_source.dart';
import '../../mocks/data/mock_websocket_remote_data_source.dart';

void main() {
  late PriceRepositoryImpl repository;
  late MockWebSocketRemoteDataSource mockWebSocketRemoteDataSource;
  late MockRestApiDataSource mockRestApiDataSource;


  setUp(() {
    mockWebSocketRemoteDataSource = MockWebSocketRemoteDataSource();
    mockRestApiDataSource = MockRestApiDataSource();
    repository = PriceRepositoryImpl(
      mockWebSocketRemoteDataSource,
      mockRestApiDataSource,
    );

  });

  final tSymbol = "AAPL";
  final tPrice = Price(symbol: tSymbol, value: 150.0);
  final tFailure =
      ServerFailure("Something went wrong :WebSocketChannelException");

  group('getPriceStream', () {
    test('should return prices from WebSocket when successful', () async {
      // Arrange
      final streamController = StreamController<Price>();
      when(() => mockWebSocketRemoteDataSource.getPriceStream(tSymbol))
          .thenAnswer((_) => streamController.stream);

      // Act
      final priceStream = repository.getPriceStream(tSymbol);

      // Emit a price
      streamController.add(tPrice);

      // Assert
      expect(await priceStream.first, Right(tPrice));
      verify(() => mockWebSocketRemoteDataSource.getPriceStream(tSymbol))
          .called(1);

      // Clean up
      streamController.close();
    });
  });

  group('getLatestPriceFromApi', () {
    test('should return price from REST API when successful', () async {
      // Arrange
      when(() => mockRestApiDataSource.fetchLatestPrice(tSymbol))
          .thenAnswer((_) async => tPrice);

      // Act
      final result = await repository.getLatestPriceFromApi(tSymbol);

      // Assert
      expect(result, Right(tPrice));
      verify(() => mockRestApiDataSource.fetchLatestPrice(tSymbol)).called(1);
    });

    test('should return failure when REST API call fails', () async {
      // Arrange
      when(() => mockRestApiDataSource.fetchLatestPrice(tSymbol))
          .thenThrow(Exception());

      // Act
      final result = await repository.getLatestPriceFromApi(tSymbol);

      // Assert
      expect(result, isA<Left<Failure, Price>>()); // Check if it's a Left
      expect(result.fold((l) => l, (r) => null),
          isA<ServerFailure>()); // Check if it's ServerFailure
      expect(result.fold((l) => l.message, (r) => ''),
          contains('Something went wrong')); // Check for error message

      verify(() => mockRestApiDataSource.fetchLatestPrice(tSymbol)).called(1);
    });
  });
}
