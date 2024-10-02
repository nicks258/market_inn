import 'package:dartz/dartz.dart';
import 'package:market_inn/domain/entities/company_detail.dart';

import '../../core/data/error/failures.dart';

abstract class CompanyDetailRepository{
  Future<Either<Failure,CompanyDetail>> getCompanyProfile(String symbol);
}