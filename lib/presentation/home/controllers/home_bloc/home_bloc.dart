import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../domain/entities/price.dart';
import '../../../../domain/usecases/get_price_stream_usecase.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPriceStreamUseCase _getPriceStreamUsecase;

  HomeBloc(this._getPriceStreamUsecase)
      : super(HomeState.internal(prices: {}, isConnected: true)) {
    on<SubscribeToPricesEvent>(_handlePriceEvent);
    add(SubscribeToPricesEvent(''));
  }

  Future _handlePriceEvent(
      SubscribeToPricesEvent event, Emitter<HomeState> emit) async {
    await for (Either<Failure, Price> either
        in _getPriceStreamUsecase(event.symbol)) {
      either.fold(
        (failure) {
          debugPrint("failure in bloc $failure");
          if (failure is SymbolNotFoundFailure) {
            debugPrint("failure in bloc $failure");
            emit(state.copyWith(errorMessage: failure.message));
          }
        },
        (price) {
          final updatedPrices = Map<String, Price>.from(state.prices);
          final previousStatePrice = updatedPrices[price.symbol];
          double priceDifference = 0.00;
          if (price.previousCloseValue != null &&
              price.previousCloseValue != 0 &&
              price.value != 0) {
            priceDifference = price.value - price.previousCloseValue!;
          } else if (price.value != 0 && previousStatePrice!=null) {
            priceDifference = (price.value - (previousStatePrice.value ));
          }
          updatedPrices[price.symbol] = Price(
              symbol: price.symbol,
              value: price.value,
              previousCloseValue: price.previousCloseValue,
              isSymbolFound: price.isSymbolFound,
              // Use current price as the previous value
              priceDifference:
              double.parse(priceDifference.toStringAsPrecision(3)));

          emit(state.copyWith(prices: updatedPrices, errorMessage: null));
        },
      );
    }
  }
}
//65513.27
