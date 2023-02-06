part of 'app_dependencies.dart';

class ProviderDependencies {
  static Future<void> init(GetIt i) async {
    i.registerFactory<ICounterProvider>(() => CounterRemoteProvider());
  }
}
