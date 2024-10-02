import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/domain/entities/price.dart';
import 'package:market_inn/domain/usecases/get_price_stream_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/domain/repositories/mock_price_repository.dart';

void main() {
  late GetPriceStreamUseCase getPriceStreamUseCase;
  late MockPriceRepository mockPriceRepository;

  setUp(() {
    mockPriceRepository = MockPriceRepository();
    getPriceStreamUseCase = GetPriceStreamUseCase(mockPriceRepository);
  });

  const tSymbol = 'AAPL';

  final tPrice = Price(
    isSymbolFound: true,
    symbol: tSymbol,
    value: 150.0,
  );

  test('should return a stream of Price from the repository on success',
      () async {
    when(() => mockPriceRepository.getPriceStream(tSymbol))
        .thenAnswer((_) => Stream.value(Right(tPrice)));

    final result = getPriceStreamUseCase(tSymbol);

    await expectLater(result, emitsInOrder([Right(tPrice)]));
    // verify the call
    verify(() => mockPriceRepository.getPriceStream(tSymbol)).called(1);
  });

  test('should return a stream of Failure from the repository on error',
      () async {
    final tFailure = ServerFailure("Fail to get price for this symbol");
    when(() => mockPriceRepository.getPriceStream(tSymbol))
        .thenAnswer((_) => Stream.value(Left(tFailure)));
    final result = getPriceStreamUseCase(tSymbol);
    await expectLater(result, emitsInOrder([Left(tFailure)]));
    // verify the call
    verify(() => mockPriceRepository.getPriceStream(tSymbol)).called(1);
  });
}
