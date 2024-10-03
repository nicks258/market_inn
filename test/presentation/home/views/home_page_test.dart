import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/domain/entities/instrument.dart';
import 'package:market_inn/core/presentation/controllers/theme_bloc/theme_bloc.dart';
import 'package:market_inn/domain/entities/price.dart';
import 'package:market_inn/presentation/home/controllers/home_bloc/home_bloc.dart';
import 'package:market_inn/presentation/home/views/home_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/services/service_locator_test.dart';
import '../../../mocks/mock_bloc/mock_home_bloc.dart';

final instrumentList = [
Instrument(exchange: '', symbol: 'AAPL', type: 'Stock'),
Instrument(exchange: '', symbol: 'GOOGL', type: 'Stock'),
];


void main() {
  late MockHomeBloc mockHomeBloc;
  setUp(() {
    mockHomeBloc = MockHomeBloc();
  });

  setUpAll(() async {
    await initTest();

    registerFallbackValue(SubscribeToPricesEvent('AAPL'));
  });

  Widget createWidgetUnderTest() {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: MaterialApp(
        home: BlocProvider<HomeBloc>(
          create: (_) => mockHomeBloc,
          child:Scaffold(body:  HomePage(
            instrumentList: instrumentList,
          ),),
        ),
      ),
    );
  }

  testWidgets('renders initial loading state', (tester) async {
    // when(()=>mockHomeBloc.add(SubscribeToPricesEvent('AAPL')))
    // Arrange: Set initial state
    when(() => mockHomeBloc.state).thenReturn(
      HomeState.internal(prices: {}, isConnected: true),
    );

    // Act: Build widget and trigger the frame
    await tester.pumpWidget(createWidgetUnderTest());

    // Assert: Check that loading UI is rendered
    expect(find.text('Market Inn'), findsOneWidget);
  });

  testWidgets('displays prices when they are loaded', (tester) async {
    // Arrange: Set state with price data
    when(() => mockHomeBloc.state).thenReturn(
      HomeState.internal(prices: {
        'AAPL': Price(symbol: 'AAPL', value: 150.00,isSymbolFound: true),
        'GOOGL': Price(symbol: 'GOOGL', value: 2800.00,isSymbolFound: true),
      }, isConnected: true),
    );

    // Act: Build widget and trigger the frame
    await tester.pumpWidget(createWidgetUnderTest());

    // Assert: Check that the prices are displayed
    expect(find.text('AAPL'), findsOneWidget);
    expect(find.text('GOOGL'), findsOneWidget);
    expect(find.text('150.00'), findsOneWidget);
    expect(find.text('2800.00'), findsOneWidget);
  });

  testWidgets('displays reconnection message when disconnected',
      (tester) async {
    // Arrange: Set state to disconnected
    when(() => mockHomeBloc.state).thenReturn(
      HomeState.internal(prices: {}, isConnected: false),
    );

    // Act: Build widget and trigger the frame
    await tester.pumpWidget(createWidgetUnderTest());

    // Assert: Check for reconnection message
    expect(find.text('Reconnecting...'), findsOneWidget);
  });
}
