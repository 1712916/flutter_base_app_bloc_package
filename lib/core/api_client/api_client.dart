import 'dart:developer';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';

import '../config/index.dart';
import 'authen_interceptor.dart';
import 'data_handle_interceptor.dart';

enum HttpMethod {
  get,
  put,
  post,
  delete,
  option,
}

extension MethodExtensions on HttpMethod {
  String get value => ['GET', 'PUT', 'POST', 'DELETE', 'OPTION'][index];
}

class ApiClient {
  static final Dio _dio = Dio()
    ..interceptors.addAll(
      [
        CurlLoggerDioInterceptor(printOnSuccess: true),
        DataHandleInterceptor(),
      ],
    );

  static int timeOut = 6000; //1000 = 1 second => 6 second

  static Future<Response?> _call(
    HttpMethod httpMethod, {
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    CancelToken? cancelToken,
    Options? options,
    bool? useToken = true,
  }) async {
    options ??= Options(headers: {});
    options.method = httpMethod.value;
    options.headers = {
      'Accept': "application/json",
      'Content-type': 'application/json; charset=utf-8',
    };
    options.sendTimeout = timeOut;
    options.receiveTimeout = timeOut;

    if (useToken ?? false) {
      _dio.interceptors.add(AuthenticateInterceptor());
    }

    try {
      return await _dio.request(
        ApiConfig.appUrl + 'api/' + url,
        queryParameters: queryParameters,
        data: data,
        cancelToken: cancelToken,
        options: options,
      );
    } catch (e, stackTrace) {
      log('Thrown an exception when call api: $e');
      log(stackTrace.toString());
      log('-----------*LOG*--------------');

      if (e is DioError) {
        return e.response;
      }

      return null;
    }
  }

  static Future<Response?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _call(
      HttpMethod.get,
      url: url,
      queryParameters: queryParameters,
    );
  }

  static Future<Response?> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) {
    return _call(
      HttpMethod.post,
      url: url,
      queryParameters: queryParameters,
      data: data,
    );
  }

  static Future<Response?> put(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) {
    return _call(
      HttpMethod.put,
      url: url,
      queryParameters: queryParameters,
      data: data,
    );
  }

  static Future<Response?> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) {
    return _call(
      HttpMethod.delete,
      url: url,
      queryParameters: queryParameters,
      data: data,
    );
  }
}
