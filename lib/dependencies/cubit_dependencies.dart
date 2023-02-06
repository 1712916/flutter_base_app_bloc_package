part of 'app_dependencies.dart';

class CubitDependencies {
  static Future<void> init(GetIt i) async {
    i.registerFactory<CounterCubit>(() => CounterCubit(counterRepository: i.get()));
  }
}
