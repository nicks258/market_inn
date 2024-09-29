part of 'theme_bloc.dart';


abstract class ThemeEvent{
  const ThemeEvent();
}

class ToggleDarkThemeEvent extends ThemeEvent{

}

class ToggleLightThemeEvent extends ThemeEvent{

}