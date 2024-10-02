import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/data/models/search_result_model.dart';
import 'package:market_inn/data/repositories/search_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/data/mock_rest_api_data_source.dart';

void main() {
  late SearchRepositoryImpl repository;
  late MockRestApiDataSource mockRestApiDataSource;

  setUp(() {
    mockRestApiDataSource = MockRestApiDataSource();
    repository = SearchRepositoryImpl(mockRestApiDataSource);
  });

  test('should return search results when API call is successful', () async {
    // Arrange
    const query = 'Apple';
    final searchResult = SearchResultModel(result: [
      SearchItem(
        description: 'Apple Inc.',
        type: 'Company',
      )
    ]);

    when(() => mockRestApiDataSource.getSearchResults(query))
        .thenAnswer((_) async => searchResult);

    final result = await repository.getSearchResults(query);

    expect(result, Right<Failure, SearchResultModel>(searchResult));
    verify(() => mockRestApiDataSource.getSearchResults(query)).called(1);
  });

  test('should return ServerFailure when API call fails', () async {
    const query = 'Apple';

    when(() => mockRestApiDataSource.getSearchResults(query))
        .thenThrow(Exception('Failed to fetch search results'));
    final result = await repository.getSearchResults(query);
    expect(result, isA<Left<Failure, SearchResultModel>>());
    expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
    verify(() => mockRestApiDataSource.getSearchResults(query)).called(1);
  });
}
