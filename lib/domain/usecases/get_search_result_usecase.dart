import 'package:dartz/dartz.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/core/domain/usecase/base_use_case.dart';
import 'package:market_inn/domain/repositories/search_repopsitory.dart';

import '../entities/search_result.dart';

class GetSearchResultUseCase extends BaseUseCase<SearchResult,String>{
  final SearchRepository _searchRepository;

  GetSearchResultUseCase(this._searchRepository);
  @override
  Future<Either<Failure, SearchResult>> call(String p)async {
    return await _searchRepository.getSearchResults(p);
  }

}