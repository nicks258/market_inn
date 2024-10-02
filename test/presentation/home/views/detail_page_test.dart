import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/presentation/controllers/theme_bloc/theme_bloc.dart';
import 'package:market_inn/core/utils/enums.dart';
import 'package:market_inn/domain/entities/company_detail.dart';
import 'package:market_inn/presentation/home/controllers/detail_bloc/detail_bloc.dart';
import 'package:market_inn/presentation/home/views/detail_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mock_bloc/mock_detail_bloc.dart';



void main() {
  late DetailBloc mockDetailBloc;

  setUp(() {
    mockDetailBloc = MockDetailBloc();
  });

  Widget createWidgetUnderTest() {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: MaterialApp(
        home: BlocProvider<DetailBloc>(
          create: (context) => mockDetailBloc,
          child: Scaffold(
            body: DetailsPage(),
          ),
        ),
      ),
    );
  }

  testWidgets('should show loading indicator when in loading state',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockDetailBloc.state)
        .thenReturn(const DetailState.internal(status: RequestStatus.loading));

    // Act
    await tester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show company details when loaded',
      (WidgetTester tester) async {
    // Arrange
    final tCompanyDetail = CompanyDetail(
      companyName: 'Apple Inc.',
      symbol: 'AAPL',
      stockExchange: 'NASDAQ',
      companyIndustry: 'Technology',
      marketCapital: 2.5,
      stockCurrency: 'USD',
      companyLogo: 'https://logo.url',
    );
    when(() => mockDetailBloc.state).thenReturn(DetailState.internal(
        status: RequestStatus.loaded, companyDetail: tCompanyDetail));

    // Act
    await tester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.text('Apple Inc.'), findsOneWidget);
    expect(find.text(' (AAPL)'), findsOneWidget);
    expect(find.text('NASDAQ'), findsOneWidget);
    expect(find.text('Technology'), findsOneWidget);
    expect(find.text('2.50 USD'), findsOneWidget);
  });

  testWidgets('should show error message when in error state',
      (WidgetTester tester) async {
    // Arrange
    when(() => mockDetailBloc.state).thenReturn(const DetailState.internal(
        status: RequestStatus.error, message: 'Error loading data'));

    // Act
    await tester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.text('Error loading data'), findsOneWidget);
  });
}
