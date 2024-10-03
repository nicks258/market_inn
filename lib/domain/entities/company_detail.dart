import 'package:equatable/equatable.dart';

import '../../data/models/company_profile_model.dart';

class CompanyDetail extends Equatable {
  final String stockExchange;
  final String stockCurrency;
  final double marketCapital;
  final String companyName;
  final String companyLogo;
  final String companyIndustry;
  final String symbol;

  const CompanyDetail(
      {this.stockExchange = "",
      this.stockCurrency = "",
      this.symbol = "",
      this.marketCapital = 0.00,
      this.companyName = "",
      this.companyLogo = "",
      this.companyIndustry = ""});

  static CompanyDetail toDomain(CompanyProfileModel model) {
    return CompanyDetail(
      stockCurrency: model.currency,
      stockExchange: model.exchange,
      companyIndustry: model.finnhubIndustry,
      companyLogo: model.logo,
      marketCapital: model.marketCapitalization,
      companyName: model.name,
      symbol: model.ticker,
    );
  }

  @override
  List<Object?> get props => [
        stockExchange,
        marketCapital,
        companyName,
        companyLogo,
        companyIndustry,
        symbol
      ];
}
