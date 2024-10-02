import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/domain/entities/company_detail.dart';
import 'package:market_inn/domain/usecases/get_company_details_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/domain/repositories/mock_company_detail_repository.dart';

void main() {
  late GetCompanyDetailsUserCase companyDetailsUserCase;
  late MockCompanyDetailRepository mockCompanyDetailRepository;

  setUp(() {
    mockCompanyDetailRepository = MockCompanyDetailRepository();
    companyDetailsUserCase = GetCompanyDetailsUserCase(mockCompanyDetailRepository);
  });

  const tSymbol = 'AAPL';

  final tCompanyDetail = CompanyDetail(
    companyName: 'Apple Inc.',
    symbol: 'AAPL',
    stockExchange: 'NASDAQ',
    marketCapital: 2.5,
    stockCurrency: 'USD',
    companyLogo: 'https://logo.url',
    companyIndustry: 'Technology',
  );

  test('should return company details when the repository call is successful',
      () async {
    when(() => mockCompanyDetailRepository.getCompanyProfile(tSymbol))
        .thenAnswer((_) async => Right(tCompanyDetail));

    final result = await companyDetailsUserCase(tSymbol);

    expect(result, Right(tCompanyDetail));
    // verify the call..
    verify(() => mockCompanyDetailRepository.getCompanyProfile(tSymbol))
        .called(1);
    verifyNoMoreInteractions(mockCompanyDetailRepository);
  });

  test('should return a failure when the repository call fails', () async {
    // Arrange
    final tFailure = ServerFailure("Fail to get company info");
    when(() => mockCompanyDetailRepository.getCompanyProfile(tSymbol))
        .thenAnswer((_) async => Left(tFailure));
    final result = await companyDetailsUserCase(tSymbol);
    expect(result, Left(tFailure));
    verify(() => mockCompanyDetailRepository.getCompanyProfile(tSymbol))
        .called(1);
    verifyNoMoreInteractions(mockCompanyDetailRepository);
  });
}
