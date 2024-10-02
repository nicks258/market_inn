import 'package:equatable/equatable.dart';

class Price extends Equatable {
  final String symbol;
  final double value;
  final double? previousCloseValue;
  final bool isSymbolFound;

  final double? priceDifference;

  @override
  List<Object?> get props =>
      [symbol, value, previousCloseValue, priceDifference, isSymbolFound];

  const Price({
    required this.symbol,
    required this.value,
    this.previousCloseValue,
    required this.isSymbolFound,
    this.priceDifference,
  });

  @override
  String toString() {
    return 'Price{ symbol: $symbol, value: $value, previousCloseValue: $previousCloseValue, isSymbolFound: $isSymbolFound, priceDifference: $priceDifference,}';
  }

  Price copyWith({
    String? symbol,
    double? value,
    double? previousCloseValue,
    bool? isSymbolFound,
    double? priceDifference,
  }) {
    return Price(
      symbol: symbol ?? this.symbol,
      value: value ?? this.value,
      previousCloseValue: previousCloseValue ?? this.previousCloseValue,
      isSymbolFound: isSymbolFound ?? this.isSymbolFound,
      priceDifference: priceDifference ?? this.priceDifference,
    );
  }
}
