import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetCheckerHelper {
  InternetCheckerHelper._();

  static Future init() async {
    _currentResult = await connectivity.checkConnectivity();
  }

  static final Connectivity _connectivity = Connectivity();

  static Connectivity get  connectivity => _connectivity;

  static bool get isConnected => _currentResult != ConnectivityResult.none;

  static ConnectivityResult _currentResult = ConnectivityResult.mobile;

  static void changeConnectivityResult(ConnectivityResult connectivityResult) {
    log('Internet change: ${connectivityResult.name}');
    _currentResult = connectivityResult;
  }

  static void checkInternetAccess({Function? onConnected, Function? onDisconnected}) {
    if (isConnected) {
       onConnected?.call();
    } else {
       onDisconnected?.call();
    }
  }
}