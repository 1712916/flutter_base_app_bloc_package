import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/counter_repository.dart';
import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit({
    required CounterRepository counterRepository,
  }) : super(const CounterState(
          isLoading: true,
        )) {
    _counterRepository = counterRepository;
  }

  late final CounterRepository _counterRepository;

  final StreamController<dynamic> _eventStream = StreamController<dynamic>.broadcast();

  Stream get eventController => _eventStream.stream;

  void dispose() {
    _eventStream.close();
    super.close();
  }

  void init() async {
    final result = await _counterRepository.getCurrentNumber();
    result.fold((l) {
      emit(state.copyWith(number: 1, isLoading: false));
    }, (entity) {
      emit(state.copyWith(number: entity.number, isLoading: false));
    });
  }

  void increment({int? number}) async {
    final result = await _counterRepository.increment(number: number);
    result.fold((l) => null, (entity) {
      _eventStream.add(entity.number);
      emit(state.copyWith(number: entity.number));
    });
  }

  void decrement({int? number}) async {
    final result = await _counterRepository.decrement(number: number);
    result.fold((l) => null, (entity) {
      _eventStream.add(entity.number);
      emit(state.copyWith(number: entity.number));
    });
  }
}
