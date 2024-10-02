part of 'detail_bloc.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState.internal(
      {@Default(RequestStatus.loading) RequestStatus? status,
      CompanyDetail? companyDetail,
      @Default("") String? message}) = _Internal;
}
