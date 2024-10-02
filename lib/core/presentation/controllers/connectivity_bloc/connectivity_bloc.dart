import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../services/connectivity_service.dart';
import '../../../services/service_locator.dart';

part 'connectivity_bloc.freezed.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final ConnectivityService connectivityService = sl<ConnectivityService>();

  ConnectivityBloc() : super(ConnectivityState.internal(true)) {
    // Listen to connectivity changes
    connectivityService.connectionStatusStream.listen(
      (event) {
        add(ConnectivityChanged(event));
      },
    );

    // Handle the ConnectivityChanged event
    on<ConnectivityChanged>((event, emit) {
      emit(ConnectivityState.internal(event.isConnected));
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
