part of 'app_dependencies.dart';

class RepositoryDependencies {
  static Future<void> init(GetIt i) async {
    i.registerFactory<CounterRepository>(() => CounterRepository(counterProvider: i.get()));
  }
}
