import 'package:dartz/dartz.dart';

import '../../../../core/api_client/base_response.dart';
import '../responses/counter_response.dart';

abstract class ICounterProvider {
  Future<CounterResponse> getCurrentNumber();
  Future<CounterResponse> increment({int? number});
  Future<CounterResponse> decrement({int? number});
}