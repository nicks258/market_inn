part of 'home_bloc.dart';

class HomeEvent {
  HomeEvent();
}

class SubscribeToPricesEvent extends HomeEvent {
  final String symbol;

  SubscribeToPricesEvent(this.symbol);
}



