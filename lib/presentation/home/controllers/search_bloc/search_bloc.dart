import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:market_inn/core/utils/enums.dart';

import '../../../../domain/entities/search_result.dart';
import '../../../../domain/usecases/get_search_result_usecase.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetSearchResultUseCase _getSearchResultUseCase;

  SearchBloc(this._getSearchResultUseCase)
      : super(const SearchState.internal()) {
    on<GetSearchResultEvent>(_handleSearchEvent);
  }

  Future _handleSearchEvent(
      GetSearchResultEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final result = await _getSearchResultUseCase(event.query);
    result.fold(
      (l) {
        emit(state.copyWith(message: l.message, status: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(
            searchResult: r.result, status: RequestStatus.loaded));
      },
    );
  }
}
