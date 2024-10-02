import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/domain/entities/price.dart';
import 'package:market_inn/domain/usecases/get_price_stream_usecase.dart';
import 'package:market_inn/presentation/home/controllers/home_bloc/home_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPriceStream extends Mock implements GetPriceStreamUseCase {}

final double instrumentPrice1 = 150.0;
final double instrumentPrice2 = 151.0;
final String instrumentSymbol = "AAPL";

void main() {
  late HomeBloc bloc;
  late MockGetPriceStream mockGetPriceStream;

  setUp(() {
    mockGetPriceStream = MockGetPriceStream();
    bloc = HomeBloc(mockGetPriceStream);
  });

  tearDown(() {
    bloc.close();
  });

  setUpAll(() {
    // Register any types that have to be passed to mocks
    registerFallbackValue(SubscribeToPricesEvent('AAPL'));
  });

  group('HomeBloc', () {
    Either<Failure, Price> error = Left(ServerFailure(
        'Max reconnection attempts reached. Giving up. Please try after sometime.'));
    blocTest<HomeBloc, HomeState>(
      'should emit price updates when new prices are streamed',
      build: () {
        // Mock the stream to return price updates
        when(() => mockGetPriceStream(instrumentSymbol)).thenAnswer(
          (_) => Stream.fromIterable([
            Right(Price(symbol: instrumentSymbol, value: instrumentPrice1,isSymbolFound: true)),
            Right(Price(
              isSymbolFound: true,
                symbol: instrumentSymbol,
                value: instrumentPrice2,
                priceDifference: instrumentPrice2 - instrumentPrice1))
          ]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(SubscribeToPricesEvent(instrumentSymbol)),
      expect: () => [
        HomeState.internal(prices: {
          instrumentSymbol: Price(
            isSymbolFound: true,
              symbol: instrumentSymbol,
              value: instrumentPrice1,
              priceDifference: 0),
        }),
        HomeState.internal(prices: {
          instrumentSymbol: Price(
            isSymbolFound: true,
              symbol: instrumentSymbol,
              value: instrumentPrice2,
              priceDifference: instrumentPrice2 - instrumentPrice1),
        }),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'should handle WebSocket disconnection and reconnection',
      build: () {
        when(() => mockGetPriceStream(instrumentSymbol)).thenAnswer(
          (_) => Stream.fromIterable([error]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(SubscribeToPricesEvent(instrumentSymbol)),
      expect: () => [
        HomeState.internal(
            prices: {},
            errorMessage:
                "Max reconnection attempts reached. Giving up. Please try after sometime.",
            isConnected: false)
      ],
    );
  });
}
