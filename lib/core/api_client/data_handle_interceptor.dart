import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class DataHandleInterceptor extends Interceptor {
  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data != null && response.data is String && (response.data as String).isNotEmpty) {
      try {
        response.data = jsonDecode(response.data);
      } catch (e, stackTrace) {
        log('Thrown an exception when parsing: $e');
        log(stackTrace.toString());
        log('-----------*LOG*--------------');
      }
    }

    log('-----------*Start-LOG*--------------');
    log("Response StatusCode: ${response.statusCode}");
    log("Response Data: ${response.data}");
    log('-----------*End-LOG*--------------');
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }
}
