import 'package:dartz/dartz.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/core/domain/usecase/base_use_case.dart';
import 'package:market_inn/domain/repositories/search_repopsitory.dart';

import '../../data/models/search_result_model.dart';

class GetSearchResultUseCase extends BaseUseCase<SearchResultModel,String>{
  final SearchRepository _searchRepository;

  GetSearchResultUseCase(this._searchRepository);
  @override
  Future<Either<Failure, SearchResultModel>> call(String p)async {
    return await _searchRepository.getSearchResults(p);
  }

}