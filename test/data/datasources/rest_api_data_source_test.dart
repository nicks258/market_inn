import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/core/resources/app_constants.dart';
import 'package:market_inn/data/datasources/rest_api_data_source.dart';
import 'package:market_inn/data/models/company_profile_model.dart';
import 'package:market_inn/data/models/search_result_model.dart';
import 'package:market_inn/domain/entities/price.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for http.Client
class MockHttpClient extends Mock implements http.Client {}

void main() {
  late RestApiDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  // Register a fallback value for Uri to avoid the error.
  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RestApiDataSourceImpl(mockHttpClient);
  });

  group('fetchLatestPrice', () {
    const symbol = 'AAPL';

    test('should return Price when the response is successful', () async {
      // Arrange
      final responseJson = jsonEncode({
        'c': 150.0,
        'pc': 145.0,
      });

      // Here we mock the `get` method of the http client
      when(() => mockHttpClient.get(Uri.parse(
          '${AppConstants.baseUrl}/api/v1/quote?symbol=$symbol&token=${AppConstants.apiKey}')))
          .thenAnswer((_) async => http.Response(responseJson, 200));

      // Act
      final result = await dataSource.fetchLatestPrice(symbol);
      // Assert
      expect(result, isA<Price>());
      expect(result.value, 150.0);  // Expected price value
      expect(result.previousCloseValue, 145.0); // Expected previous close value
      verify(() => mockHttpClient.get(any())).called(1);
    });

    test('should throw ServerFailure when the response is an error', () async {
      // Arrange
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('Error', 404));

      // Act & Assert
      expect(
            () async => await dataSource.fetchLatestPrice(symbol),
        throwsA(isA<ServerFailure>()),
      );
      verify(() => mockHttpClient.get(any())).called(1);
    });
  });

  group('getCompanyProfile', () {
    const symbol = 'AAPL';

    test('should return CompanyProfileModel when the response is successful', () async {
      // Arrange
      final responseJson = jsonEncode({
        'currency': 'USD',
        'finnhubIndustry': 'Technology',
        'logo': 'https://example.com/logo.png',
        'name': 'Apple Inc.',
        'marketCapitalization': 2500000000,
        'exchange': 'NASDAQ',
      });

      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response(responseJson, 200));

      // Act
      final result = await dataSource.getCompanyProfile(symbol);

      // Assert
      expect(result, isA<CompanyProfileModel>());
      expect(result.name, 'Apple Inc.');
      expect(result.currency, 'USD');
      verify(() => mockHttpClient.get(any())).called(1);
    });


    test('should throw ServerFailure when the response is an error in getCompanyProfile()', () async {
      // Arrange
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('Error', 404));

      // Act & Assert
      expect(
            () async => await dataSource.getCompanyProfile(symbol),
        throwsA(isA<ServerFailure>()),
      );
      verify(() => mockHttpClient.get(any())).called(1);
    });

  });

  group('getSearchResults', () {
    const query = 'Apple';

    test('should return SearchResultModel when the response is successful', () async {
      // Arrange
      final responseJson = jsonEncode({
        'results': [], // Example structure of your search result
      });

      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response(responseJson, 200));

      // Act
      final result = await dataSource.getSearchResults(query);

      // Assert
      expect(result, isA<SearchResultModel>());
      verify(() => mockHttpClient.get(any())).called(1);
    });

    test('should throw ServerFailure when the response is an error', () async {
      // Arrange
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('Error', 404));

      // Act & Assert
      expect(
            () async => await dataSource.getSearchResults(query),
        throwsA(isA<ServerFailure>()),
      );
      verify(() => mockHttpClient.get(any())).called(1);
    });
  });
}
