import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:market_inn/data/datasources/rest_api_data_source.dart';
import 'package:market_inn/data/datasources/websocket_remote_data_source.dart';
import 'package:market_inn/data/repositories/price_repository_impl.dart';
import 'package:market_inn/domain/repositories/price_repository.dart';
import 'package:market_inn/domain/usecases/get_price_stream_usecase.dart';
import 'package:market_inn/presentation/home/controllers/home_bloc/home_bloc.dart';

import '../../mocks/data/mock_rest_api_data_source.dart';
import '../../mocks/data/mock_websocket_remote_data_source.dart';
import '../utils/mock_timer.dart';

final sl = GetIt.instance;

Future<void> initTest() async {
  sl.registerLazySingleton<WebSocketRemoteDataSource>(
    () => MockWebSocketRemoteDataSource(),
  );
  sl.registerLazySingleton<RestApiDataSource>(
    () => MockRestApiDataSource(),
  );
  sl.registerLazySingleton<PriceRepository>(
    () => PriceRepositoryImpl(
      MockWebSocketRemoteDataSource(),
      MockRestApiDataSource(),
      timerCreator: (duration, callback) {
        return MockTimer();
      },
    ),
  );
  sl.registerLazySingleton<GetPriceStreamUseCase>(
      () => GetPriceStreamUseCase(sl()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl<GetPriceStreamUseCase>()));
}
