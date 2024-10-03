import 'package:dartz/dartz.dart';
import 'package:market_inn/core/data/error/failures.dart';

import '../entities/search_result.dart';

abstract class SearchRepository{
  Future<Either<Failure,SearchResult>> getSearchResults(String query);
}