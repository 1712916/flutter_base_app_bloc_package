import 'package:flutter/material.dart';
import 'package:flutter_base_app_bloc_package/core/blocs/theme_cubit.dart';
import 'package:flutter_base_app_bloc_package/resources/theme/text_themes.dart';

import 'app_colors.dart';

class ThemeResource {
  static ThemeData getTheme({ThemeData? theme, required ThemeMode themeMode}) {
    ThemeData themeData = theme ?? ThemeData();
    AppColors appColors = AppColors.getColor(themeMode);
    TextTheme textTheme = CustomTextTheme.getTheme(themeMode);
    return themeData.copyWith(
      primaryColor: appColors.primary,
      textTheme: textTheme,
      // backgroundColor: appColors.backgroundColor,
      // canvasColor: appColors.canvasColor,
      // cardColor: appColors.cardColor,
      // hintColor: appColors.hintColor,
      // errorColor: appColors.errorColor,
      // focusColor: appColors.focusColor,
      // disabledColor: appColors.disabledColor,
      // dividerColor: appColors.dividerColor,
      // shadowColor: appColors.shadowColor,
    );
  }
}
