// data/datasources/rest_api_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/price.dart';

class RestApiDataSource {
  final String apiKey;

  RestApiDataSource({required this.apiKey});

  Future<Price?> fetchLatestPrice(String symbol) async {
    final url = Uri.parse('https://finnhub.io/api/v1/quote?symbol=$symbol&token=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Price(
        symbol: symbol,
        value: data['c'] + 0.0,
        previousCloseValue: data['pc'] + 0.0
      );
    } else {
      throw Exception('Failed to fetch price data from API');
    }
  }
}
