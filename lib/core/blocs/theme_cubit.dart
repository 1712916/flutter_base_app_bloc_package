import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_app_bloc_package/resources/theme/text_themes.dart';

import '../../resources/theme/app_colors.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  Future setUp() async {
    //todo: read from shareRef
  }

  void switchMode(ThemeMode themeMode) {
    emit(themeMode);
  }

  AppColors get colors => AppColors.getColor(state);

  CustomTextTheme get textTheme => CustomTextTheme.getTheme(state);
}
