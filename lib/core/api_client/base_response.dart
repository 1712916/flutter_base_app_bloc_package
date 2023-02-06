import 'status_code.dart';

class ErrorResponse {
  final HttpStatusCode statusCode;
  final String message;

  ErrorResponse({
    required this.statusCode,
    required this.message,
  });
}


class SuccessResponse {
  final HttpStatusCode statusCode;
  final String message;

  SuccessResponse({
    required this.statusCode,
    required this.message,
  });
}

class BaseResponse<T> {
  final HttpStatusCode statusCode;
  final String? message;
  final T? data;

  BaseResponse({
    required this.statusCode,
    this.message,
    this.data,
  });
}
