part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.internal(
      {@Default([]) List<SearchItem>? searchResult,
      @Default(RequestStatus.loading) RequestStatus? status,
      @Default('') String? message}) = _Internal;
}
