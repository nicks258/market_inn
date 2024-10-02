import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.lightTheme) {
    on<ToggleDarkThemeEvent>(_switchDarkMode);
    on<ToggleLightThemeEvent>(_switchLightMode);
  }

  Future<void> _switchDarkMode(ThemeEvent event, Emitter<ThemeState> emit) async {
    emit(ThemeState.darkTheme);
  }

  Future<void> _switchLightMode(ThemeEvent event, Emitter<ThemeState> emit) async {
    emit(ThemeState.lightTheme);
  }
}
