// final jsonList = json.decode(jsonStr) as List;
// final list = jsonList.map((e) => InstrumentModelItem.fromJson(e)).toList();

import 'safe_convert.dart';

class Instrument {
  // MSFT
  final String symbol;
  // NASDAQ
  final String exchange;
  // Stock
  final String type;

  Instrument({
    this.symbol = "",
    this.exchange = "",
    this.type = "",
  });

  factory Instrument.fromJson(Map<String, dynamic>? json) => Instrument(
    symbol: asT<String>(json, 'symbol'),
    exchange: asT<String>(json, 'exchange'),
    type: asT<String>(json, 'type'),
  );

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'exchange': exchange,
    'type': type,
  };

  Instrument copyWith({
    String? symbol,
    String? exchange,
    String? type,
  }) {
    return Instrument(
      symbol: symbol ?? this.symbol,
      exchange: exchange ?? this.exchange,
      type: type ?? this.type,
    );
  }
}

