import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_app_bloc_package/core/base_page/event_mixin.dart';

import '../../data/repositories/counter_repository.dart';
import 'counter_state.dart';

class Counter2Cubit extends Cubit<CounterState> with EventMixin<int?> {
  Counter2Cubit({
    required CounterRepository counterRepository,
  }) : super(const CounterState(
          isLoading: true,
        )) {
    _counterRepository = counterRepository;
  }

  late final CounterRepository _counterRepository;

  void init() async {
    final result = await _counterRepository.getCurrentNumber();
    result.fold((l) {}, (entity) {
      emit(state.copyWith(number: entity.number, isLoading: false));
    });
  }

  void increment({int? number}) async {
    final result = await _counterRepository.increment(number: number);
    result.fold((l) => null, (entity) {
      addEvent(entity.number);
      emit(state.copyWith(number: entity.number));
    });
  }

  void decrement({int? number}) async {
    final result = await _counterRepository.decrement(number: number);
    result.fold((l) => null, (entity) {
      addEvent(entity.number);
      emit(state.copyWith(number: entity.number));
    });
  }
}
