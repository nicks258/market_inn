import 'package:get_it/get_it.dart';
import 'package:market_inn/data/datasources/rest_api_data_source.dart';
import 'package:market_inn/presentation/home/controllers/home_bloc/home_bloc.dart';

import '../../data/datasources/websocket_remote_data_source.dart';
import '../../data/repositories/websocket_repository_impl.dart';
import '../../domain/repositories/websocket_repository.dart';
import '../../domain/usecases/get_price_stream_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Remote Data Sources
  sl.registerLazySingleton<WebSocketRemoteDataSource>(
    () => WebSocketRemoteDataSource(
        apiKey: 'crrpue9r01qmgcu655g0crrpue9r01qmgcu655gg'),
    dispose: (webSocketRemoteDataSource) => webSocketRemoteDataSource.close(),
  );
  sl.registerLazySingleton<RestApiDataSource>(
    () => RestApiDataSource(apiKey: 'crrpue9r01qmgcu655g0crrpue9r01qmgcu655gg'),
  );

  // Repositories
  sl.registerLazySingleton<PriceRepository>(
    () => PriceRepositoryImpl(
        sl<WebSocketRemoteDataSource>(), sl<RestApiDataSource>()),
    dispose: (repository) => repository.dispose(),
  );

  // Use Cases
  sl.registerLazySingleton<GetPriceStreamUseCase>(
      () => GetPriceStreamUseCase(sl<PriceRepository>()));

  // Bloc
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl<GetPriceStreamUseCase>()));
}
