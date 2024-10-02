import 'package:dartz/dartz.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/core/domain/usecase/base_use_case.dart';
import 'package:market_inn/domain/entities/company_detail.dart';
import 'package:market_inn/domain/repositories/company_detail_repository.dart';

class GetCompanyDetailsUserCase extends BaseUseCase<CompanyDetail, String> {
  final CompanyDetailRepository _companyDetailRepository;

  GetCompanyDetailsUserCase(this._companyDetailRepository);

  @override
  Future<Either<Failure, CompanyDetail>> call(String p) async {
    return _companyDetailRepository.getCompanyProfile(p);
  }
}
