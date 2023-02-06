import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_base_app_bloc_package/core/config/shared_preference_key.dart';

import 'env_manager.dart';
import 'environment.dart';

///TODO: set api url here
const String _devUrl = '';
const String _prodUrl = '';

class ApiConfig {
  ApiConfig._();

  static String get appUrl => _getUrl();

  static String _token = '';
  static String _refreshToken = '';

  static String get token => _token;

  static String get refreshToken => _refreshToken;

  static void setToken(String token) {
    _token = token;
    _storageToken();
  }

  static void setRefreshToken(String refreshToken) {
    _refreshToken = refreshToken;
    _storageRefreshToken();
  }

  static void clearToken() async {
    _token = '';
    _refreshToken = '';
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: SharedReferenceKeys.token);
  }

  ///Use when open app
  static Future loadToken() async {
    const _storage = FlutterSecureStorage();
    final String? tokenString = await _storage.read(key: SharedReferenceKeys.token);
    final String? refreshTokenString = await _storage.read(key: SharedReferenceKeys.refreshToken);
    print('token: ${tokenString}');
    if (tokenString?.isNotEmpty ?? false) {
      setToken(tokenString!);
    }
    if (refreshTokenString?.isNotEmpty ?? false) {
      setRefreshToken(refreshToken);
    }
  }

  ///Use to save new token
  static Future _storageToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.write(key: SharedReferenceKeys.token, value: token);
  }

  static Future _storageRefreshToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.write(key: SharedReferenceKeys.refreshToken, value: refreshToken);
  }

  static String _getUrl() {
    switch (EnvManager.env) {
      case Env.dev:
        return _devUrl;
      case Env.prod:
        return _prodUrl;
    }
  }
}
