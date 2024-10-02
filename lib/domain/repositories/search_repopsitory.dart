import 'package:dartz/dartz.dart';
import 'package:market_inn/core/data/error/failures.dart';

import '../../data/models/search_result_model.dart';

abstract class SearchRepository{
  Future<Either<Failure,SearchResultModel>> getSearchResults(String query);
}