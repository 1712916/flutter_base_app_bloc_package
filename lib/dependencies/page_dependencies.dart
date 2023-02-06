part of 'app_dependencies.dart';

class PageDependencies {
  static Future<void> init(GetIt i) async {
    i.registerFactory<Widget>(() => const CounterPage(), instanceName: RouteManager.example);
  }
}
