import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/utils/enums.dart';
import 'package:market_inn/data/models/search_result_model.dart';
import 'package:market_inn/presentation/home/controllers/search_bloc/search_bloc.dart';
import 'package:market_inn/presentation/home/views/search_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_bloc/mock_search_bloc.dart';

void main() {
  late SearchBloc mockSearchBloc;

  setUp(() {
    mockSearchBloc = MockSearchBloc();
  });

  Widget createWidgetUnderTest(List<SearchItem> searchResults) {
    return BlocProvider<SearchBloc>(
      create: (context) => mockSearchBloc,
      child: MaterialApp(
        home: Scaffold(
          body: SearchPage(),
        ),
      ),
    );
  }

  final tSearchResults = [
    SearchItem(
        description: 'APPLE INC',
        type: 'Common Stock',
        symbol: "AAPL",
        displaySymbol: "AAPL"),
    SearchItem(
        description: 'APPLIED UV INC',
        type: 'Common Stock',
        symbol: "AUVIQ",
        displaySymbol: "AUVIQ"),
  ];

  testWidgets('should show search results when loaded',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockSearchBloc.state).thenReturn(SearchState.internal(
        status: RequestStatus.loaded, searchResult: tSearchResults));

    // Act
    await tester.pumpWidget(createWidgetUnderTest(tSearchResults));

    // Assert
    expect(find.text('APPLE INC'), findsOneWidget);
    expect(find.text('APPLIED UV INC'), findsOneWidget);
    expect(find.text('Common Stock'), findsExactly(2));
  });

  testWidgets('should show loading indicator when in loading state',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockSearchBloc.state)
        .thenReturn(const SearchState.internal(status: RequestStatus.loading));

    // Act
    await tester.pumpWidget(createWidgetUnderTest([]));

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error message when in error state',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockSearchBloc.state).thenReturn(const SearchState.internal(
        status: RequestStatus.error, message: 'Error loading data'));

    // Act
    await tester.pumpWidget(createWidgetUnderTest([]));

    // Assert
    expect(find.text('Error loading data'), findsOneWidget);
  });

  testWidgets('should show No results when in search results is empty',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockSearchBloc.state).thenReturn(const SearchState.internal(
        status: RequestStatus.loaded, message: '', searchResult: []));

    // Act
    await tester.pumpWidget(createWidgetUnderTest([]));

    // Assert
    expect(find.text('No Results'), findsOneWidget);
  });
}
