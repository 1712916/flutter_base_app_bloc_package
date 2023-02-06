import '../../../../core/api_client/index.dart';

class CounterResponse extends BaseResponse<int> {
  CounterResponse({
    required HttpStatusCode statusCode,
    String? message,
    int? data,
  }) : super(statusCode: statusCode, message: message, data: data);
}