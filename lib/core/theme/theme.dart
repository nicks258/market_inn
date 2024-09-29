import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xffdbb9f9),
      surfaceTint: Color(0xff6e528a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6e528a),
      onPrimaryContainer: Color(0xff280d42),
      secondary: Color(0xff665a6f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffedddf6),
      onSecondaryContainer: Color(0xff211829),
      tertiary: Color(0xff6e528a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfff0dbff),
      onTertiaryContainer: Color(0xff280d42),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffff7fe),
      onSurface: Color(0xff1e1a20),
      onSurfaceVariant: Color(0xff4a454e),
      outline: Color(0xff7c757e),
      outlineVariant: Color(0xffccc4ce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff332f35),
      inversePrimary: Color(0xffdbb9f9),
      primaryFixed: Color(0xfff0dbff),
      onPrimaryFixed: Color(0xff280d42),
      primaryFixedDim: Color(0xffdbb9f9),
      onPrimaryFixedVariant: Color(0xff563b71),
      secondaryFixed: Color(0xffedddf6),
      onSecondaryFixed: Color(0xff211829),
      secondaryFixedDim: Color(0xffd0c1da),
      onSecondaryFixedVariant: Color(0xff4d4357),
      tertiaryFixed: Color(0xfff0dbff),
      onTertiaryFixed: Color(0xff280d42),
      tertiaryFixedDim: Color(0xffdbb9f9),
      onTertiaryFixedVariant: Color(0xff563b71),
      surfaceDim: Color(0xffdfd8df),
      surfaceBright: Color(0xfffff7fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9f1f9),
      surfaceContainer: Color(0xfff3ebf3),
      surfaceContainerHigh: Color(0xffeee6ee),
      surfaceContainerHighest: Color(0xffe8e0e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff51376d),
      surfaceTint: Color(0xff6e528a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff8568a2),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff493f52),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff7c7086),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff51376d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8568a2),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fe),
      onSurface: Color(0xff1e1a20),
      onSurfaceVariant: Color(0xff46414a),
      outline: Color(0xff635d66),
      outlineVariant: Color(0xff7f7882),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff332f35),
      inversePrimary: Color(0xffdbb9f9),
      primaryFixed: Color(0xff8568a2),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff6c5088),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff7c7086),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff63586c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8568a2),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff6c5088),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdfd8df),
      surfaceBright: Color(0xfffff7fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9f1f9),
      surfaceContainer: Color(0xfff3ebf3),
      surfaceContainerHigh: Color(0xffeee6ee),
      surfaceContainerHighest: Color(0xffe8e0e8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2f1549),
      surfaceTint: Color(0xff6e528a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff51376d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff281e30),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff493f52),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2f1549),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff51376d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fe),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff27222a),
      outline: Color(0xff46414a),
      outlineVariant: Color(0xff46414a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff332f35),
      inversePrimary: Color(0xfff6e7ff),
      primaryFixed: Color(0xff51376d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3a2055),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff493f52),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff32293b),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff51376d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3a2055),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffdfd8df),
      surfaceBright: Color(0xfffff7fe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9f1f9),
      surfaceContainer: Color(0xfff3ebf3),
      surfaceContainerHigh: Color(0xffeee6ee),
      surfaceContainerHighest: Color(0xffe8e0e8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffdbb9f9),
      surfaceTint: Color(0xffdbb9f9),
      onPrimary: Color(0xff3e2459),
      primaryContainer: Color(0xff563b71),
      onPrimaryContainer: Color(0xfff0dbff),
      secondary: Color(0xffd0c1da),
      onSecondary: Color(0xff362c3f),
      secondaryContainer: Color(0xff4d4357),
      onSecondaryContainer: Color(0xffedddf6),
      tertiary: Color(0xffdbb9f9),
      onTertiary: Color(0xff3e2459),
      tertiaryContainer: Color(0xff563b71),
      onTertiaryContainer: Color(0xfff0dbff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff151218),
      onSurface: Color(0xffe8e0e8),
      onSurfaceVariant: Color(0xffccc4ce),
      outline: Color(0xff968e98),
      outlineVariant: Color(0xff4a454e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e0e8),
      inversePrimary: Color(0xff6e528a),
      primaryFixed: Color(0xfff0dbff),
      onPrimaryFixed: Color(0xff280d42),
      primaryFixedDim: Color(0xffdbb9f9),
      onPrimaryFixedVariant: Color(0xff563b71),
      secondaryFixed: Color(0xffedddf6),
      onSecondaryFixed: Color(0xff211829),
      secondaryFixedDim: Color(0xffd0c1da),
      onSecondaryFixedVariant: Color(0xff4d4357),
      tertiaryFixed: Color(0xfff0dbff),
      onTertiaryFixed: Color(0xff280d42),
      tertiaryFixedDim: Color(0xffdbb9f9),
      onTertiaryFixedVariant: Color(0xff563b71),
      surfaceDim: Color(0xff151218),
      surfaceBright: Color(0xff3c383e),
      surfaceContainerLowest: Color(0xff100d12),
      surfaceContainerLow: Color(0xff1e1a20),
      surfaceContainer: Color(0xff221e24),
      surfaceContainerHigh: Color(0xff2c292e),
      surfaceContainerHighest: Color(0xff373339),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff6e528a),
      surfaceTint: Color(0xffdbb9f9),
      onPrimary: Color(0xff22063d),
      primaryContainer: Color(0xffa384c0),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd4c5de),
      onSecondary: Color(0xff1b1324),
      secondaryContainer: Color(0xff998ca3),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdfbefe),
      onTertiary: Color(0xff22063d),
      tertiaryContainer: Color(0xffa384c0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff151218),
      onSurface: Color(0xfffff9fc),
      onSurfaceVariant: Color(0xffd1c8d3),
      outline: Color(0xffa8a0ab),
      outlineVariant: Color(0xff88818b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e0e8),
      inversePrimary: Color(0xff573c72),
      primaryFixed: Color(0xfff0dbff),
      onPrimaryFixed: Color(0xff1d0137),
      primaryFixedDim: Color(0xffdbb9f9),
      onPrimaryFixedVariant: Color(0xff442a5f),
      secondaryFixed: Color(0xffedddf6),
      onSecondaryFixed: Color(0xff160d1f),
      secondaryFixedDim: Color(0xffd0c1da),
      onSecondaryFixedVariant: Color(0xff3c3245),
      tertiaryFixed: Color(0xfff0dbff),
      onTertiaryFixed: Color(0xff1d0137),
      tertiaryFixedDim: Color(0xffdbb9f9),
      onTertiaryFixedVariant: Color(0xff442a5f),
      surfaceDim: Color(0xff151218),
      surfaceBright: Color(0xff3c383e),
      surfaceContainerLowest: Color(0xff100d12),
      surfaceContainerLow: Color(0xff1e1a20),
      surfaceContainer: Color(0xff221e24),
      surfaceContainerHigh: Color(0xff2c292e),
      surfaceContainerHighest: Color(0xff373339),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff6e528a),
      surfaceTint: Color(0xffdbb9f9),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffdfbefe),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffff9fc),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd4c5de),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9fc),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffdfbefe),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff151218),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffff9fc),
      outline: Color(0xffd1c8d3),
      outlineVariant: Color(0xffd1c8d3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe8e0e8),
      inversePrimary: Color(0xff371d52),
      primaryFixed: Color(0xfff3e0ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffdfbefe),
      onPrimaryFixedVariant: Color(0xff22063d),
      secondaryFixed: Color(0xfff1e1fb),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd4c5de),
      onSecondaryFixedVariant: Color(0xff1b1324),
      tertiaryFixed: Color(0xfff3e0ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffdfbefe),
      onTertiaryFixedVariant: Color(0xff22063d),
      surfaceDim: Color(0xff151218),
      surfaceBright: Color(0xff3c383e),
      surfaceContainerLowest: Color(0xff100d12),
      surfaceContainerLow: Color(0xff1e1a20),
      surfaceContainer: Color(0xff221e24),
      surfaceContainerHigh: Color(0xff2c292e),
      surfaceContainerHighest: Color(0xff373339),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}


TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
  GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}