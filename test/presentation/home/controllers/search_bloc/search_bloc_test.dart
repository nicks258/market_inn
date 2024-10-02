import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/core/utils/enums.dart';
import 'package:market_inn/data/models/search_result_model.dart';
import 'package:market_inn/presentation/home/controllers/search_bloc/search_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/domain/usecases/mock_get_search_result_usecase.dart';

void main() {
  late SearchBloc searchBloc;
  late MockGetSearchResultUseCase mockGetSearchResultUseCase;

  setUp(() {
    mockGetSearchResultUseCase = MockGetSearchResultUseCase();
    searchBloc = SearchBloc(mockGetSearchResultUseCase);
  });

  const tQuery = 'App';
  final tSearchResults = [
    SearchItem(description: 'APPLE INC', type: 'Common Stock',symbol: "AAPL",displaySymbol: "AAPL"),
    SearchItem(description: 'APPLIED UV INC', type: 'Common Stock',symbol: "AUVIQ",displaySymbol: "AUVIQ"),
  ];

  test('initial state should be loading', () {
    expect(searchBloc.state, equals(const SearchState.internal(status: RequestStatus.loading)));
  });

  test('should emit [loading, loaded] when data is successfully fetched',
      () async {
    // Arrange
    when(() => mockGetSearchResultUseCase(tQuery)).thenAnswer(
        (_) async => Right(SearchResultModel(result: tSearchResults)));

    // Assert later
    final expected = [
      const SearchState.internal(status: RequestStatus.loading), // Initial loading state
      SearchState.internal(
          status: RequestStatus.loaded, searchResult: tSearchResults),
    ];
    expectLater(searchBloc.stream, emitsInOrder(expected));

    // Act
    searchBloc.add(GetSearchResultEvent(tQuery));
  });

  test('should emit [loading, error] when fetching data fails', () async {
    // Arrange
    when(() => mockGetSearchResultUseCase(tQuery)).thenAnswer(
        (_) async => Left(ServerFailure('Failed to fetch search results')));

    // Assert later
    final expected = [
      const SearchState.internal(),
      SearchState.internal(
          status: RequestStatus.error,
          message: 'Failed to fetch search results'),
    ];
    expectLater(searchBloc.stream, emitsInOrder(expected));

    // Act
    searchBloc.add(GetSearchResultEvent(tQuery));
  });
}
