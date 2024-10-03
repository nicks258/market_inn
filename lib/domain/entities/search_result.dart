import '../../data/models/search_result_model.dart';

class SearchResult {
  final int count;
  final List<SearchItemEntity> result;

  SearchResult({
     this.count=0,
    required this.result,
  });
  static SearchResult toDomain(SearchResultModel model) {
    return SearchResult(
      count: model.count,
      result: model.result.map((item) => SearchItemMapper.toDomain(item)).toList(),
    );
  }
}

class SearchItemEntity {
  final String description;
  final String displaySymbol;
  final String symbol;
  final String type;

  SearchItemEntity({
     this.description="",
     this.displaySymbol="",
     this.symbol ="",
     this.type ="",
  });



}


class SearchItemMapper {
  static SearchItemEntity toDomain(SearchItem model) {
    return SearchItemEntity(
      description: model.description,
      displaySymbol: model.displaySymbol,
      symbol: model.symbol,
      type: model.type,
    );
  }

  static SearchItem fromDomain(SearchItemEntity entity) {
    return SearchItem(
      description: entity.description,
      displaySymbol: entity.displaySymbol,
      symbol: entity.symbol,
      type: entity.type,
    );
  }
}