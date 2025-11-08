import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plant_app/src/core/blocs/app_bloc_observer.dart';

import 'package:plant_app/src/router/plant_router_observer.dart';
import 'package:plant_app/src/router/router.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  DependencyInjection._();

  static FutureOr<void> init() async {
    _registerRouter();
    _registerRouterObserver();
    _configureBlocInjection();
  }

  static void _registerRouter() {
    if (!getIt.isRegistered<AppRouter>()) {
      getIt.registerLazySingleton<AppRouter>(() => AppRouter());
    }
  }

  static void _registerRouterObserver() {
    if (!getIt.isRegistered<PlantRouterObserver>()) {
      getIt.registerLazySingleton<PlantRouterObserver>(
        () => PlantRouterObserver(),
      );
    }
  }

  static void _configureBlocInjection() {
    Bloc.observer = AppBlocObserver();
  }
}
