library flutter_base_app_bloc_package;

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_base_app_bloc_package/core/blocs/app_bloc_observer.dart';
import 'package:flutter_base_app_bloc_package/core/blocs/theme_cubit.dart';
import 'package:flutter_base_app_bloc_package/core/config/api_config.dart';
import 'package:flutter_base_app_bloc_package/core/config/env_manager.dart';
import 'package:flutter_base_app_bloc_package/core/ui_helpers/internet_checker_helper.dart';
import 'package:flutter_base_app_bloc_package/dependencies/app_dependencies.dart';
import 'package:flutter_base_app_bloc_package/resources/theme/theme_data.dart';
import 'package:flutter_base_app_bloc_package/routers/route_manager.dart';

///Use [mainAppContext] to remove MyApp of [Navigator]
///example: Navigator.of(mainAppContext!).pop();
BuildContext? _mainAppContext;

BuildContext? get mainAppContext => _mainAppContext;

void _setContext(BuildContext context) {
  _mainAppContext = context;
}

class GateWay {
  ///init app
  static Future _init() async {
    Bloc.observer = AppBlocObserver();

    await Future.wait([
      AppDependencies.init(),
      EnvManager.loadEnv(),
      ApiConfig.loadToken(),
      InternetCheckerHelper.init(),
    ]);
  }

  static void openApp(BuildContext context, {String? initRouteName}) async {
    //set context to manage navigator
    _setContext(context);

    await _init();

    final themeCubit = ThemeCubit();

    //run app
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => themeCubit),
              ],
              child: MyApp(initRouteName: initRouteName,
              ),
            ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.initRouteName}) : super(key: key);

  final String? initRouteName;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  StreamSubscription<ConnectivityResult>? _internetSubscription;

  bool _isFirstCheckInternet = true;

  @override
  void initState() {
    super.initState();
    _internetSubscription = InternetCheckerHelper.connectivity.onConnectivityChanged.distinct().listen(_internetListener);
  }

  void _internetListener(ConnectivityResult result) {
    InternetCheckerHelper.changeConnectivityResult(result);

    if (_isFirstCheckInternet) {
      _isFirstCheckInternet = false;
      if (result == ConnectivityResult.none) {
        //Handle when lost internet when open app
        //todo:
      }
      return;
    }

    //Handle internet change when second time it change
    //todo:
  }


  @override
  Widget build(BuildContext context) {
    /*
    * Create a [Navigator] to manage navigate page inside this package
    * */
    return BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return Theme(
            data: ThemeResource.getTheme(themeMode: state, theme: Theme.of(context)),
            child: Navigator(
              key: RouteManager.navigatorKey,
              initialRoute: widget.initRouteName ?? RouteManager.getIniRoute(),
              onGenerateRoute: RouteManager.getRoute,
              onUnknownRoute: RouteManager.getUnknownRoute,
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    //reset dependency injection
    GetIt.instance.reset();

    //cancel internet listener
    _internetSubscription?.cancel();

    super.dispose();
  }
}
