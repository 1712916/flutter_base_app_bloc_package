import '../../data/responses/counter_response.dart';
import '../../../../core/parses/parse_util.dart';
class CounterEntity {
  final int? number;

  CounterEntity({this.number});

  factory CounterEntity.fromResponse(CounterResponse response) {
    return CounterEntity(number: response.data);
  }
}