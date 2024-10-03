import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/domain/entities/search_result.dart';
import 'package:market_inn/domain/usecases/get_search_result_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/domain/repositories/mock_search_repopsitory.dart';

void main() {
  late GetSearchResultUseCase getSearchResultUseCase;
  late MockSearchRepository mockSearchRepository;

  setUp(() {
    mockSearchRepository = MockSearchRepository();
    getSearchResultUseCase = GetSearchResultUseCase(mockSearchRepository);
  });

  const tQuery = 'Apple';

  final tSearchItem = SearchItemEntity(
    description: 'Apple Inc.',
    type: 'Company',
  );

  final tSearchResultModel = SearchResult(
    result: [tSearchItem],
  );

  test('should return search results when the repository call is successful',
      () async {
    when(() => mockSearchRepository.getSearchResults(tQuery))
        .thenAnswer((_) async => Right(tSearchResultModel));
    final result = await getSearchResultUseCase(tQuery);
    expect(result, Right(tSearchResultModel));
    verify(() => mockSearchRepository.getSearchResults(tQuery)).called(1);
    verifyNoMoreInteractions(mockSearchRepository);
  });

  test('should return a failure when the repository call fails', () async {
    final tFailure = ServerFailure("Something went wrong. Try after sometime");
    when(() => mockSearchRepository.getSearchResults(tQuery))
        .thenAnswer((_) async => Left(tFailure));
    final result = await getSearchResultUseCase(tQuery);
    expect(result, Left(tFailure));
    verify(() => mockSearchRepository.getSearchResults(tQuery)).called(1);
    verifyNoMoreInteractions(mockSearchRepository);
  });
}
