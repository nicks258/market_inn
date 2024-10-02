import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:market_inn/data/datasources/rest_api_data_source.dart';
import 'package:market_inn/data/repositories/company_detail_repository_impl.dart';
import 'package:market_inn/data/repositories/search_repository_impl.dart';
import 'package:market_inn/domain/repositories/company_detail_repository.dart';
import 'package:market_inn/domain/repositories/search_repopsitory.dart';
import 'package:market_inn/domain/usecases/get_company_details_usecase.dart';
import 'package:market_inn/domain/usecases/get_search_result_usecase.dart';
import 'package:market_inn/presentation/home/controllers/home_bloc/home_bloc.dart';
import 'package:market_inn/presentation/home/controllers/search_bloc/search_bloc.dart';

import '../../data/datasources/websocket_remote_data_source.dart';
import '../../data/repositories/price_repository_impl.dart';
import '../../domain/repositories/price_repository.dart';
import '../../domain/usecases/get_price_stream_usecase.dart';
import 'connectivity_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<ConnectivityService>(
    () => ConnectivityService(),
    dispose: (service) => service.dispose(),
  );

  // Remote Data Sources
  sl.registerLazySingleton<WebSocketRemoteDataSource>(
    () => WebSocketRemoteDataSource(),
    dispose: (webSocketRemoteDataSource) => webSocketRemoteDataSource.close(),
  );
  sl.registerLazySingleton<RestApiDataSource>(
    () => RestApiDataSourceImpl(http.Client()),
  );

  // Repositories
  sl.registerLazySingleton<PriceRepository>(
    () => PriceRepositoryImpl(
        sl<WebSocketRemoteDataSource>(), sl<RestApiDataSource>()),
    dispose: (repository) => repository.dispose(),
  );
  sl.registerLazySingleton<CompanyDetailRepository>(
    () => CompanyDetailRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton<GetPriceStreamUseCase>(
      () => GetPriceStreamUseCase(sl<PriceRepository>()));
  sl.registerLazySingleton<GetCompanyDetailsUserCase>(
    () => GetCompanyDetailsUserCase(sl()),
  );
  sl.registerLazySingleton<GetSearchResultUseCase>(
    () => GetSearchResultUseCase(sl()),
  );

  // Bloc
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl<GetPriceStreamUseCase>()));
  sl.registerFactory<SearchBloc>(
    () => SearchBloc(sl<GetSearchResultUseCase>()),
  );
}
