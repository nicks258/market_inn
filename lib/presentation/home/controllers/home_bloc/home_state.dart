part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.internal(
      {required Map<String, Price> prices,
      @Default(true) bool isConnected,

      String? errorMessage}) = _Internal;
}
