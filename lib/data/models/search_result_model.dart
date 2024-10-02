import '../../core/domain/entities/safe_convert.dart';


class SearchResultModel {
  // 25
  final int count;
  final List<SearchItem> result;

  SearchResultModel({
    this.count = 0,
    required this.result,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic>? json) => SearchResultModel(
    count: asT<int>(json, 'count'),
    result: asT<List>(json, 'result').map((e) => SearchItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'count': count,
    'result': result.map((e) => e.toJson()).toList(),
  };

  SearchResultModel copyWith({
    int? count,
    List<SearchItem>? result,
  }) {
    return SearchResultModel(
      count: count ?? this.count,
      result: result ?? this.result,
    );
  }
}

class SearchItem {
  // BIOATLA INC
  final String description;
  // BCAB
  final String displaySymbol;
  // BCAB
  final String symbol;
  // Common Stock
  final String type;

  SearchItem({
    this.description = "",
    this.displaySymbol = "",
    this.symbol = "",
    this.type = "",
  });

  factory SearchItem.fromJson(Map<String, dynamic>? json) => SearchItem(
    description: asT<String>(json, 'description'),
    displaySymbol: asT<String>(json, 'displaySymbol'),
    symbol: asT<String>(json, 'symbol'),
    type: asT<String>(json, 'type'),
  );

  Map<String, dynamic> toJson() => {
    'description': description,
    'displaySymbol': displaySymbol,
    'symbol': symbol,
    'type': type,
  };

  SearchItem copyWith({
    String? description,
    String? displaySymbol,
    String? symbol,
    String? type,
  }) {
    return SearchItem(
      description: description ?? this.description,
      displaySymbol: displaySymbol ?? this.displaySymbol,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
    );
  }
}

