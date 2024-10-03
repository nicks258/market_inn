import 'package:dartz/dartz.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/data/datasources/rest_api_data_source.dart';
import 'package:market_inn/domain/repositories/search_repopsitory.dart';

import '../../domain/entities/search_result.dart';

class SearchRepositoryImpl extends SearchRepository {
  final RestApiDataSource _restApiDataSource;

  SearchRepositoryImpl(this._restApiDataSource);

  @override
  Future<Either<Failure, SearchResult>> getSearchResults(
      String query) async {
    try {
      final data = await _restApiDataSource.getSearchResults(query);
      return Right(SearchResult.toDomain(data));
    } catch (e) {
      return Left(ServerFailure("Something went wrong :${e.toString()}"));
    }
  }
}
