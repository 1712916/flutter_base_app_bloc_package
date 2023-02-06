import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_base_app_bloc_package/features/example_feature/data/provider/interface.dart';
import 'package:flutter_base_app_bloc_package/features/example_feature/data/provider/remote_provider.dart';
import 'package:flutter_base_app_bloc_package/features/example_feature/data/repositories/counter_repository.dart';
import 'package:flutter_base_app_bloc_package/features/example_feature/presentation/bloc/counter_cubit.dart';
import 'package:flutter_base_app_bloc_package/features/example_feature/presentation/pages/counter_2_page.dart';
import 'package:flutter_base_app_bloc_package/features/example_feature/presentation/pages/counter_page.dart';
import 'package:flutter_base_app_bloc_package/routers/route_manager.dart';

part 'cubit_dependencies.dart';
part 'page_dependencies.dart';
part 'provider_dependencies.dart';
part 'repository_dependencies.dart';

class AppDependencies {
  static GetIt get injector => GetIt.I;

  static Future<void> init() async {
    await _initAllDependency();
  }

  static Future<void> _initAllDependency() async {
    await Future.wait([
      ProviderDependencies.init(injector),
      RepositoryDependencies.init(injector),
      CubitDependencies.init(injector),
      PageDependencies.init(injector),
    ]);
  }
}
