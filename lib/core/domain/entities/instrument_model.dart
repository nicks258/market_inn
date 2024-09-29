// final jsonList = json.decode(jsonStr) as List;
// final list = jsonList.map((e) => InstrumentModelItem.fromJson(e)).toList();

import 'safe_convert.dart';

class InstrumentModelItem {
  // MSFT
  final String symbol;
  // NASDAQ
  final String exchange;
  // Stock
  final String type;

  InstrumentModelItem({
    this.symbol = "",
    this.exchange = "",
    this.type = "",
  });

  factory InstrumentModelItem.fromJson(Map<String, dynamic>? json) => InstrumentModelItem(
    symbol: asT<String>(json, 'symbol'),
    exchange: asT<String>(json, 'exchange'),
    type: asT<String>(json, 'type'),
  );

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'exchange': exchange,
    'type': type,
  };

  InstrumentModelItem copyWith({
    String? symbol,
    String? exchange,
    String? type,
  }) {
    return InstrumentModelItem(
      symbol: symbol ?? this.symbol,
      exchange: exchange ?? this.exchange,
      type: type ?? this.type,
    );
  }
}

