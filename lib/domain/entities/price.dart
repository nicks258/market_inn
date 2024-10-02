import 'package:equatable/equatable.dart';

class Price extends Equatable {
  final String symbol;
  final double value;
  final double? previousCloseValue;

  final double? priceDifference;

  const Price( {
    required this.symbol,
    required this.value,
    this.priceDifference,
    this.previousCloseValue,
  });

  @override

  List<Object?> get props => [symbol,value,previousCloseValue,priceDifference];
}
