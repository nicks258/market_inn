import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/data/models/company_profile_model.dart'; // Adjust according to your model location
import 'package:market_inn/data/repositories/company_detail_repository_impl.dart';
import 'package:market_inn/domain/entities/company_detail.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/data/mock_rest_api_data_source.dart';


void main() {
  late CompanyDetailRepositoryImpl repository;
  late MockRestApiDataSource mockRestApiDataSource;

  setUp(() {
    mockRestApiDataSource = MockRestApiDataSource();
    repository = CompanyDetailRepositoryImpl(mockRestApiDataSource);
  });

  group('getCompanyProfile', () {
    const symbol = 'AAPL';

    test('should return company details when API call is successful', () async {
      // Arrange
      final companyProfile = CompanyProfileModel(
        currency: 'USD',
        finnhubIndustry: 'Technology',
        logo: 'logo.png',
        name: 'Apple Inc.',
        marketCapitalization: 2.5,
        exchange: 'NASDAQ',
      );

      // Set up the mock to return a successful response
      when(() => mockRestApiDataSource.getCompanyProfile(symbol))
          .thenAnswer((_) async => companyProfile);

      // Act
      final result = await repository.getCompanyProfile(symbol);

      // Assert
      expect(result, Right<Failure, CompanyDetail>(CompanyDetail(
        stockCurrency: companyProfile.currency,
        companyIndustry: companyProfile.finnhubIndustry,
        companyLogo: companyProfile.logo,
        companyName: companyProfile.name,
        symbol: symbol,
        marketCapital: companyProfile.marketCapitalization,
        stockExchange: companyProfile.exchange,
      )));
      verify(() => mockRestApiDataSource.getCompanyProfile(symbol)).called(1);
    });

    test('should return ServerFailure when API call fails', () async {
      // Arrange
      when(() => mockRestApiDataSource.getCompanyProfile(symbol))
          .thenThrow(ServerFailure('Failed to fetch company profile'));

      // Act
      final result = await repository.getCompanyProfile(symbol);

      // Assert
      expect(result, isA<Left<Failure, CompanyDetail>>());
      expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      verify(() => mockRestApiDataSource.getCompanyProfile(symbol)).called(1);
    });
  });
}
