import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app_bloc_package/core/config/app_config.dart';

import '../../routers/route_manager.dart';
import '../config/index.dart';
import 'index.dart';

class AuthenticateInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (ApiConfig.token.isNotEmpty) {
      options.headers['x-access-token'] = ApiConfig.token;
    }
    super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    bool checkUnAuthorized() {
      if (response?.statusCode == HttpStatusCode.unauthorized.code && response?.data is Map) {
        return response?.data['message'] == 'Token expired' || response?.data['message'] == 'Token does not exist';
      }
      return false;
    }

    ///TODO: clear if unnecessary
    //Should clear app state here
    if (checkUnAuthorized()) {
      log("$runtimeType error ${response?.statusCode} ${HttpStatusCode.unauthorized.code}");
      try {
        final Dio dio = Dio();

        final requestResponse = await dio.post(ApiConfig.appUrl + 'auth/refresh-token', data: {
          "refreshToken": ApiConfig.refreshToken,
        });

        if (requestResponse.statusCode?.statusHttpCode == HttpStatusCode.success) {
          final accessTokenResponse = AccessTokenResponse.fromJson(requestResponse.data);
          if (accessTokenResponse.id != null && accessTokenResponse.refreshToken != null) {
            ApiConfig.setToken(accessTokenResponse.id!);
            ApiConfig.setRefreshToken(accessTokenResponse.refreshToken!);

            err.requestOptions.headers['x-access-token'] = ApiConfig.token;
            //create request with new access token
            final opts = Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            );
            final cloneReq = await dio.request(
              err.requestOptions.path,
              options: opts,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );
            dio.close();
            return handler.resolve(cloneReq);
          }
        }
        _gotoLogin();
      } catch (e) {
        _gotoLogin();
      }
      return err;
    }

    return super.onError(err, handler);
  }

  _gotoLogin() {
    AppConfig.getInstance().logout();

    if (RouteManager.navigatorKey.currentState?.context != null) {
      Navigator.of(RouteManager.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
        RouteManager.login,
        (route) => false,
      );
    }
  }
}

///TODO: clear if unnecessary
class AccessTokenResponse {
  final String? id;
  final String? expiredOn;
  final String? refreshToken;
  final String? userId;
  final String? createdAt;

  AccessTokenResponse({
    this.id,
    this.expiredOn,
    this.refreshToken,
    this.userId,
    this.createdAt,
  });

  factory AccessTokenResponse.fromJson(Map<String, dynamic> json) {
    return AccessTokenResponse(
      id: json["id"].toString(),
      expiredOn: json["expiredOn"].toString(),
      refreshToken: json["refreshToken"].toString(),
      userId: json["userId"].toString(),
      createdAt: json["createdAt"].toString(),
    );
  }
}
