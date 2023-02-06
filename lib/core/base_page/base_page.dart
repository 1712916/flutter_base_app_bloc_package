import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_app_bloc_package/core/blocs/theme_cubit.dart';
import 'package:flutter_base_app_bloc_package/core/ui_helpers/keyboard_helper.dart';
import 'package:flutter_base_app_bloc_package/resources/index.dart';
import 'package:flutter_base_app_bloc_package/resources/theme/text_themes.dart';

abstract class BasePageState<T extends StatefulWidget, C extends Cubit> extends State<T> {
  static const String blocKey = 'bloc';

  BasePageState();

  Color? get backGroundColor => null;

  bool isBody = false;

  C? _cubit;

  C get cubit => _cubit!;

  bool _isCubitValue = false;

  bool isFirstLoad = true;

  AppColors get colors => context.read<ThemeCubit>().colors;

  CustomTextTheme get textTheme => context.read<ThemeCubit>().textTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstLoad && mounted) {
      getPageSettings(ModalRoute.of(context)!.settings.arguments);
      isFirstLoad = false;
    }
  }

  void getPageSettings(Object? arguments){
    if(arguments is Map && arguments[BasePageState.blocKey] != null) {
      if (arguments[BasePageState.blocKey] is C) {
        if (arguments[BasePageState.blocKey] != null) {
          _cubit = arguments[BasePageState.blocKey];
          _isCubitValue = true;
        }
      }
    }
  }

  PreferredSizeWidget? buildAppbar() => null;

  Widget buildContent() => const SizedBox.shrink();

  buildFloatingActionButton() {}

  bool shouldPop() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop();
      },
      child: GestureDetector(
        onTap: () => KeyboardHelper.hideKeyBoard(context),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isCubitValue) {
      return BlocProvider.value(
        value: cubit,
        child: isBody
            ? buildContent()
            : Scaffold(
          appBar: buildAppbar(),
          body: buildContent(),
          backgroundColor: backGroundColor,
          floatingActionButton: buildFloatingActionButton(),
        ),
      );
    }
    return BlocProvider(
      create: (context) => cubit,
      child: isBody
          ? buildContent()
          : Scaffold(
        appBar: buildAppbar(),
        body: buildContent(),
        backgroundColor: backGroundColor,
        floatingActionButton: buildFloatingActionButton(),
      ),
    );
  }
}