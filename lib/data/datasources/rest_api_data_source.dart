import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:market_inn/core/resources/app_constants.dart';
import 'package:market_inn/data/models/company_profile_model.dart';

import '../../core/data/error/failures.dart';
import '../../domain/entities/price.dart';
import '../models/search_result_model.dart';

abstract class RestApiDataSource {
  Future<Price> fetchLatestPrice(String symbol);

  Future<CompanyProfileModel> getCompanyProfile(String symbol);

  Future<SearchResultModel> getSearchResults(String query);
}

class RestApiDataSourceImpl extends RestApiDataSource {
  final http.Client httpClient;

  RestApiDataSourceImpl(this.httpClient);

  @override
  Future<Price> fetchLatestPrice(String symbol) async {
    try {
      final url = Uri.parse(
          '${AppConstants.baseUrl}/api/v1/quote?symbol=$symbol&token=${dotenv.get('apiKey')}');
      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if(data['c']==0 && data['d']==null && data['pc']==0){
           throw SymbolNotFoundFailure("Price not found for $symbol");
        }
        debugPrint("value is ${data['pc'] + 0.0}");
        return Price(
            symbol: symbol,
            value: data['c'] + 0.0,
            isSymbolFound: true,
            previousCloseValue: data['pc'] + 0.0);
      }
      throw ServerFailure('Failed to fetch price data from API');
    } on Exception catch (e) {
      throw ServerFailure('Failed to fetch price data from API');
    }
  }

  @override
  Future<CompanyProfileModel> getCompanyProfile(String symbol) async {
    try {
      final url = Uri.parse(
          '${AppConstants.baseUrl}/api/v1/stock/profile2?symbol=$symbol&token=${dotenv.get('apiKey')}');
      final response = await httpClient.get(url);
      if (response.statusCode == 200 && response.body!='{}') {
        return CompanyProfileModel.fromJson(jsonDecode(response.body));
      }else{
        throw SymbolNotFoundFailure("Company details not found");
      }
    } on Exception catch (e) {
      throw ServerFailure("Something went wrong");
    }
  }

  @override
  Future<SearchResultModel> getSearchResults(String query) async {
    try {
      final url = Uri.parse(
          '${AppConstants.baseUrl}/api/v1/search?q=$query&exchange=US&token=${dotenv.get('apiKey')}');
      final response = await httpClient.get(url);
      if (response.statusCode == 200) {
        return SearchResultModel.fromJson(jsonDecode(response.body));
      } else {
        throw ServerFailure(jsonDecode(response.body));
      }
    } on Exception catch (e) {
      throw ServerFailure("Something went wrong");
    }
  }
}
