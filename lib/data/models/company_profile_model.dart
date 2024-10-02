

import '../../core/domain/entities/safe_convert.dart';

class CompanyProfileModel {
  // US
  final String country;
  // USD
  final String currency;
  // USD
  final String estimateCurrency;
  // NASDAQ NMS - GLOBAL MARKET
  final String exchange;
  // Technology
  final String finnhubIndustry;
  // 1980-12-12
  final String ipo;
  // https://static2.finnhub.io/file/publicdatany/finnhubimage/stock_logo/AAPL.png
  final String logo;
  // 3463350.36820015
  final double marketCapitalization;
  // Apple Inc
  final String name;
  // 14089961010
  final String phone;
  // 15204.14
  final double shareOutstanding;
  // AAPL
  final String ticker;
  // https://www.apple.com/
  final String weburl;

  CompanyProfileModel({
    this.country = "",
    this.currency = "",
    this.estimateCurrency = "",
    this.exchange = "",
    this.finnhubIndustry = "",
    this.ipo = "",
    this.logo = "",
    this.marketCapitalization = 0.0,
    this.name = "",
    this.phone = "",
    this.shareOutstanding = 0.0,
    this.ticker = "",
    this.weburl = "",
  });

  factory CompanyProfileModel.fromJson(Map<String, dynamic>? json) => CompanyProfileModel(
    country: asT<String>(json, 'country'),
    currency: asT<String>(json, 'currency'),
    estimateCurrency: asT<String>(json, 'estimateCurrency'),
    exchange: asT<String>(json, 'exchange'),
    finnhubIndustry: asT<String>(json, 'finnhubIndustry'),
    ipo: asT<String>(json, 'ipo'),
    logo: asT<String>(json, 'logo'),
    marketCapitalization: asT<double>(json, 'marketCapitalization'),
    name: asT<String>(json, 'name'),
    phone: asT<String>(json, 'phone'),
    shareOutstanding: asT<double>(json, 'shareOutstanding'),
    ticker: asT<String>(json, 'ticker'),
    weburl: asT<String>(json, 'weburl'),
  );

  Map<String, dynamic> toJson() => {
    'country': country,
    'currency': currency,
    'estimateCurrency': estimateCurrency,
    'exchange': exchange,
    'finnhubIndustry': finnhubIndustry,
    'ipo': ipo,
    'logo': logo,
    'marketCapitalization': marketCapitalization,
    'name': name,
    'phone': phone,
    'shareOutstanding': shareOutstanding,
    'ticker': ticker,
    'weburl': weburl,
  };

  CompanyProfileModel copyWith({
    String? country,
    String? currency,
    String? estimateCurrency,
    String? exchange,
    String? finnhubIndustry,
    String? ipo,
    String? logo,
    double? marketCapitalization,
    String? name,
    String? phone,
    double? shareOutstanding,
    String? ticker,
    String? weburl,
  }) {
    return CompanyProfileModel(
      country: country ?? this.country,
      currency: currency ?? this.currency,
      estimateCurrency: estimateCurrency ?? this.estimateCurrency,
      exchange: exchange ?? this.exchange,
      finnhubIndustry: finnhubIndustry ?? this.finnhubIndustry,
      ipo: ipo ?? this.ipo,
      logo: logo ?? this.logo,
      marketCapitalization: marketCapitalization ?? this.marketCapitalization,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      shareOutstanding: shareOutstanding ?? this.shareOutstanding,
      ticker: ticker ?? this.ticker,
      weburl: weburl ?? this.weburl,
    );
  }
}

