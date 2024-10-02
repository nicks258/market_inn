import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:market_inn/domain/entities/company_detail.dart';
import 'package:market_inn/domain/usecases/get_company_details_usecase.dart';

import '../../../../core/utils/enums.dart';

part 'detail_bloc.freezed.dart';
part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final GetCompanyDetailsUserCase _getCompanyDetailsUserCase;

  DetailBloc(this._getCompanyDetailsUserCase)
      : super(const DetailState.internal()) {
    on<FetchDetailEvent>(_fetchSymbolDetails);
  }

  Future _fetchSymbolDetails(
      FetchDetailEvent event, Emitter<DetailState> emit) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final details = await _getCompanyDetailsUserCase(event.symbol);
    details.fold(
      (l) {
        emit(state.copyWith(message: l.message, status: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, companyDetail: r));
      },
    );
  }
}
