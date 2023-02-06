import 'package:flutter/material.dart';

//todo: need to change to fit your project
abstract class AppColors {
  AppColors();

  factory AppColors.getColor(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return LightColor();
      case ThemeMode.dark:
        return DarkColor();
      default:
        return LightColor();
    }
  }

  Color get primary;

  //*Text
  Color get black;

  Color get greyDarkest;

  Color get greyDark;

  Color get grey;

  Color get greyLight;

  Color get greyLightest;

  Color get white;

  //*Feedback
  Color get info;

  Color get success;

  Color get warning;

  Color get error;

  // Button
  Color get strokeColor;

  Color get linear;
}

class LightColor extends AppColors {

  @override
  Color get primary => const Color(0xFF04DDF9);

  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get greyDarkest => const Color(0xFF1A1A1A);

  @override
  Color get greyDark => const Color(0xFF333333);

  @override
  Color get grey => const Color(0xFF666666);

  @override
  Color get greyLight => const Color(0xFF999999);

  @override
  Color get greyLightest => const Color(0xFFCCCCCC);

  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get info => const Color(0xFF1D4ED8);

  @override
  Color get success => const Color(0xFF047857);


  @override
  Color get warning => const Color(0xFFB45309);

  @override
  Color get error => const Color(0xFFBE123C);

  @override
  Color get strokeColor => const Color(0xFF18191F);

  @override
  Color get linear => const Color(0xFFFFF3FE);
}

class DarkColor extends AppColors {
  @override
  Color get primary => const Color(0xFF04DDF9);

  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get greyDarkest => const Color(0xFF1A1A1A);

  @override
  Color get greyDark => const Color(0xFF333333);

  @override
  Color get grey => const Color(0xFF666666);

  @override
  Color get greyLight => const Color(0xFF999999);

  @override
  Color get greyLightest => const Color(0xFFCCCCCC);

  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get info => const Color(0xFF1D4ED8);

  @override
  Color get success => const Color(0xFF047857);


  @override
  Color get warning => const Color(0xFFB45309);

  @override
  Color get error => const Color(0xFFBE123C);

  @override
  Color get strokeColor => const Color(0xFF18191F);

  @override
  Color get linear => const Color(0xFFFFF3FE);
}
