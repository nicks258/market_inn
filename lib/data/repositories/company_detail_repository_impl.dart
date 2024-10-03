import 'package:dartz/dartz.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/data/datasources/rest_api_data_source.dart';
import 'package:market_inn/domain/entities/company_detail.dart';

import '../../domain/repositories/company_detail_repository.dart';

class CompanyDetailRepositoryImpl extends CompanyDetailRepository {
  final RestApiDataSource _restApiDataSource;

  CompanyDetailRepositoryImpl(this._restApiDataSource);



  @override
  Future<Either<Failure, CompanyDetail>> getCompanyProfile(
      String symbol) async {
    try {
      final companyProfile = await _restApiDataSource.getCompanyProfile(symbol);
      return Right(CompanyDetail.toDomain(companyProfile));
    }
    on SymbolNotFoundFailure catch(e){
      return Left(e);
    }
    on ServerFailure catch (e) {
      return Left(e);
    }
  }
}
