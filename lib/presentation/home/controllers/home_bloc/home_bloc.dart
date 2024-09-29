import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/data/error/failures.dart';
import '../../../../core/domain/entities/instrument_model.dart';
import '../../../../domain/entities/price.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/usecases/get_price_stream_usecase.dart';

part 'home_state.dart';

part 'home_event.dart';

part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPriceStreamUseCase getPriceStreamUsecase;

  HomeBloc(this.getPriceStreamUsecase)
      : super(HomeState.internal(prices: {}, isConnected: true)) {
    on<SubscribeToPricesEvent>(_handlePriceEvent);
  }

  Future _handlePriceEvent(
      SubscribeToPricesEvent event, Emitter<HomeState> emit) async {
    await for (Either<Failure, Price> either
        in getPriceStreamUsecase(event.symbol)) {
      either.fold(
        (failure) {
          emit(state.copyWith(
              isConnected: false, errorMessage: failure.message));
        },
        (price) {
          final updatedPrices = Map<String, Price>.from(state.prices);
          final currentPrice = updatedPrices[price.symbol];
          double priceDifference = 0.00;
          if (price.previousCloseValue != null &&
              price.previousCloseValue != 0) {
            priceDifference = price.value - price.previousCloseValue!;
          } else {
            priceDifference = (price.value - (currentPrice?.value ?? 0));
          }
          if (currentPrice != null) {
            // Correctly update the previous value
            updatedPrices[price.symbol] = Price(
                symbol: price.symbol,
                value: price.value,
                previousCloseValue: price.previousCloseValue,
                previousValue: currentPrice.value,
                // Use current price as the previous value
                priceDifference: priceDifference);
          } else {
            // For the first update, previousValue is null
            updatedPrices[price.symbol] = Price(
                symbol: price.symbol,
                value: price.value,
                previousCloseValue: price.previousCloseValue,
                previousValue: null,
                // No previous value yet
                priceDifference: priceDifference);
          }

          emit(state.copyWith(prices: updatedPrices, errorMessage: null));
        },
      );
    }
  }
}
//65513.27
