import 'package:flutter/material.dart';

abstract class CustomTextTheme extends TextTheme {
  const CustomTextTheme();

  factory CustomTextTheme.getTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return LightTextTheme();
      case ThemeMode.dark:
        return DarkTextTheme();
      default:
        return LightTextTheme();
    }
  }

  TextStyle get body14Medium;
}

class LightTextTheme extends CustomTextTheme {
  @override
  TextStyle get body14Medium => TextStyle();
}

class DarkTextTheme extends CustomTextTheme {
  @override
  TextStyle get body14Medium => TextStyle();
}
