import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';

class AppConfig {
  AppConfig._();

  static final AppConfig _shared = AppConfig._();

  factory AppConfig.getInstance() => _shared;

  void logout() {
    ApiConfig.clearToken();
    _clearSharedData();
  }

  void _clearSharedData() {
    SharedPreferences.getInstance().then((prefs) => prefs.clear());
  }

  void login({required String token, required String refreshToken, required String email}) {
    ApiConfig.setToken(token);
    ApiConfig.setRefreshToken(refreshToken);
  }

  bool get isLogin => ApiConfig.token.isNotEmpty;
}