// main.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:market_inn/core/extensions/context_extensions.dart';
import 'package:market_inn/core/presentation/controllers/connectivity_bloc/connectivity_bloc.dart';
import 'package:market_inn/core/presentation/widgets/colored_safe_area.dart';
import 'package:market_inn/presentation/home/controllers/home_bloc/home_bloc.dart';
import 'package:market_inn/presentation/home/controllers/search_bloc/search_bloc.dart';
import 'package:market_inn/presentation/home/views/home_page.dart';

import 'core/domain/entities/instrument.dart';
import 'core/presentation/controllers/theme_bloc/theme_bloc.dart';
import 'core/services/service_locator.dart';
import 'core/theme/theme.dart';
List<Instrument> instrumentList = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await dotenv.load(fileName: "assets/.env");
  await readJson();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider(
            create: (context) => ConnectivityBloc(),
          ),
          BlocProvider(
            create: (context)=> sl<HomeBloc>()

          ),
          BlocProvider(
            create: (context) =>
            sl<SearchBloc>(),
          ),
        ],
        child: Builder(
          builder: (context) {
            final themeState = context
                .watch<ThemeBloc>()
                .state;
            final connectivityState = context
                .watch<ConnectivityBloc>()
                .state;

            return MaterialApp(
              theme: themeState.themeData.brightness == Brightness.light
                  ? theme.light()
                  : theme.dark(),
              home: ColoredSafeArea(
                  child: Scaffold(
                    body: Stack(
                      children: [
                        HomePage(
                          instrumentList: instrumentList,
                        ),
                        if (!connectivityState.isConnected)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: context.width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.width / 64,
                                  vertical: context.height / 64),
                              color: context.colors.error,
                              child: Text(
                                'No internet connection detected. Prices may not reflect real-time updates.',
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )
                      ],
                    ),
                  )),
            );
          },
        ));
  }
}

Future<void> readJson() async {
  try {
    final String response =
    await rootBundle.loadString('assets/resource/instruments.json');
    final instrumentData = await json.decode(response) as List;
    instrumentList =
        instrumentData.map((e) => Instrument.fromJson(e)).toList();
  }  catch (e) {
    final instrumentData = await json.decode(defaultJsonList) as List;
    instrumentList =
        instrumentData.map((e) => Instrument.fromJson(e)).toList();
    debugPrint("error in reading file switching to default list");
  }
}

final defaultJsonList = '[{"symbol": "AAPL","exchange": "NASDAQ","type": "Stock"},{"symbol": "INTC","exchange": "NASDAQ","type": "Stock"},{"symbol": "AMZN","exchange": "NASDAQ","type": "Stock"},{"symbol": "META","exchange": "NASDAQ","type": "Stock"},{"symbol": "MSFT","exchange": "NASDAQ","type": "Stock"},{"symbol": "NVDA","exchange": "NASDAQ","type": "Stock"}]';
