import 'package:dartz/dartz.dart';

import '../../../../core/api_client/base_response.dart';
import '../../../../core/api_client/status_code.dart';
import '../../presentation/entities/counter_entity.dart';
import '../provider/index.dart';
import '../responses/counter_response.dart';

class CounterRepository {
  CounterRepository({
    required ICounterProvider counterProvider,
  }) : _counterProvider = counterProvider;

  final ICounterProvider _counterProvider;

  Future<Either<ErrorResponse, CounterEntity>> getCurrentNumber() async {
    await Future.delayed(const Duration(seconds: 3));
    final CounterResponse response = await _counterProvider.getCurrentNumber();
    if (response.statusCode == HttpStatusCode.success) {
      return  Right(CounterEntity.fromResponse(response));
    }

    return Left(ErrorResponse(
      statusCode: response.statusCode,
      message: response.message ?? 'Some thing Error occurred!',
    ));
  }

  Future<Either<ErrorResponse, CounterEntity>> increment({int? number}) async {
    final response = await _counterProvider.increment(number: number);
    if (response.statusCode == HttpStatusCode.success) {
      return  Right(CounterEntity.fromResponse(response));
    }

    return Left(ErrorResponse(
      statusCode: response.statusCode,
      message: response.message ?? 'Some thing Error occurred!',
    ));
  }

  Future<Either<ErrorResponse, CounterEntity>> decrement({int? number}) async {
    final response = await _counterProvider.decrement(number: number);
    if (response.statusCode == HttpStatusCode.success) {
      return  Right(CounterEntity.fromResponse(response));
    }

    return Left(ErrorResponse(
      statusCode: response.statusCode,
      message: response.message ?? 'Some thing Error occurred!',
    ));
  }
}
