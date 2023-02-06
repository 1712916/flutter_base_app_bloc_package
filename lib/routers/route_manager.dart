import 'package:flutter/material.dart';
import 'package:flutter_base_app_bloc_package/core/config/app_config.dart';
import 'package:get_it/get_it.dart';

abstract class RouteManager {
  RouteManager._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static OverlayState? get overlay => navigatorKey.currentState?.overlay;

  static String get home => '/home';

  static String get login => '/login';

  static String get example => '/example';

  static String getIniRoute() {
    if (AppConfig.getInstance().isLogin) {
      return home;
    }
    return login;
  }

  static Route<dynamic>? getRoute(RouteSettings settings) {
    try {
      final widget = GetIt.I.get<Widget>(instanceName: settings.name);
      return MaterialPageRoute(builder: (_) => widget, settings: settings);
    } catch (e) {
      return null;
    }
  }

  static Route<dynamic>? getUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Builder(builder: (context) {
            return Text(
              '404 Page Not Found',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            );
          }),
        ),
      ),
      settings: settings,
    );
  }
}
