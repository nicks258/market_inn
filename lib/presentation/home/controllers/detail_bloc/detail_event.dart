part of 'detail_bloc.dart';

class DetailEvent {}

class FetchDetailEvent extends DetailEvent{
  final String symbol;

  FetchDetailEvent({required this.symbol});
}
