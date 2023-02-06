import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routers/route_manager.dart';
import 'environment.dart';
import 'shared_preference_key.dart';

class EnvManager {
  EnvManager._();

  //when build change this line
  static bool get isBuildProd => true;

  static Env? _env;

  static Env get env => _env ?? Env.dev;

  static Future loadEnv() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? envString = prefs.getString(SharedReferenceKeys.env);

    if (envString == Env.prod.toString()) {
      _env = Env.prod;
    } else {
      _env = Env.dev;
    }
  }

  static Future saveEnv(Env env, BuildContext context) async {
    if (env == _env) {
      Navigator.of(context).pop();
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.clear();
    if (result) {
      final result = await prefs.setString(SharedReferenceKeys.env, env.toString());
      if (result) {
        _env = env;
        Navigator.of(context).pushNamedAndRemoveUntil(RouteManager.login, (route) => false);
        return;
      }
    }
    const snackBar = SnackBar(
      content: Text('Have An Error when change Environment!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
