import 'package:equatable/equatable.dart';

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
        this.stockCurrency="",
        this.symbol="",
      this.marketCapital = 0.00,
      this.companyName = "",
      this.companyLogo = "",
      this.companyIndustry = ""});

  @override
  List<Object?> get props =>
      [stockExchange, marketCapital, companyName, companyLogo, companyIndustry, symbol];
}
