// main.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_inn/presentation/home/controllers/home_bloc/home_bloc.dart';
import 'package:market_inn/presentation/home/views/home_page.dart';
import 'core/domain/entities/instrument_model.dart';
import 'core/presentation/controllers/theme_bloc/theme_bloc.dart';
import 'core/services/service_locator.dart';
import 'core/theme/theme.dart';

List<InstrumentModelItem> instrumentList = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await readJson();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.themeData.brightness == Brightness.light
                ? theme.light()
                : theme.dark(),
            home: BlocProvider(
              create: (_)
              {
                debugPrint("instruments_length-> ${instrumentList.length}");
               return sl<HomeBloc>()..add(SubscribeToPricesEvent(instrumentList[0].symbol));
               },
              // create: (_) => HomeBloc(sl())..add(SubscribeToPricesEvent(instrumentList[0].symbol)),
              // create: (context) {
              //   final bloc = sl<HomeBloc>()..add(SubscribeToPricesEvent(instrumentList[0].symbol));
              //   for (final i in instrumentList) {
              //     bloc.add(SubscribeToPricesEvent((i.symbol)));
              //   }
              //   return bloc;
              // },
              child: HomePage(
                instrumentList: instrumentList,
              ),
            ),
          );
        },
      ),
    );
  }
}

Future<void> readJson() async {
  final String response =
      await rootBundle.loadString('assets/resource/instruments.json');
  final instrumentData = await json.decode(response) as List;
  instrumentList =
      instrumentData.map((e) => InstrumentModelItem.fromJson(e)).toList();

}
