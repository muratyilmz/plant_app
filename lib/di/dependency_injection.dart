import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:plant_app/app/core/blocs/app_bloc_observer.dart';
import 'package:plant_app/app/core/blocs/theme_cubit/theme_cubit.dart';
import 'package:plant_app/app/core/config/app_config.dart';
import 'package:plant_app/app/core/network/network_client.dart';
import 'package:plant_app/app/core/network/onboarding_storage_service.dart';
import 'package:plant_app/app/features/home/data/repository/article_repository_impl.dart';
import 'package:plant_app/app/features/home/data/repository/plant_category_repository_impl.dart';
import 'package:plant_app/app/features/home/domain/repository/article_repository.dart';
import 'package:plant_app/app/features/home/domain/repository/plant_category.repository.dart';
import 'package:plant_app/app/features/onboarding/presentation/cubit/on_boarding_manager_cubit.dart';
import 'package:plant_app/app/router/plant_router_observer.dart';
import 'package:plant_app/app/router/router.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  DependencyInjection._();

  static FutureOr<void> init() async {
    _registerRouter();
    _registerRouterObserver();
    _configureBlocInjection();
    _registerOnboardingServices();
    _registerCubits();
    _registerNetworkClient();
    _registerRepositories();
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

  static void _registerOnboardingServices() {
    if (!getIt.isRegistered<OnboardingStorageService>()) {
      getIt.registerLazySingleton<OnboardingStorageService>(
        () => OnboardingStorageService(),
      );
    }
  }

  static void _registerCubits() {
    if (!getIt.isRegistered<OnBoardingManagerCubit>()) {
      getIt.registerFactory<OnBoardingManagerCubit>(
        () => OnBoardingManagerCubit(
          pageCount: 3,
          storageService: getIt<OnboardingStorageService>(),
        ),
      );
    }

    if (!getIt.isRegistered<ThemeCubit>()) {
      getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
    }
  }

  static void _registerNetworkClient() {
    if (!getIt.isRegistered<NetworkClient>()) {
      getIt.registerLazySingleton<NetworkClient>(
        () => NetworkClient(baseUrl: AppConfig.baseUrl),
      );
    }
  }

  static void _registerRepositories() {
    if (!getIt.isRegistered<ArticleRepository>()) {
      getIt.registerLazySingleton<ArticleRepository>(
        () => ArticleRepositoryImpl(getIt<NetworkClient>()),
      );
    }

    if (!getIt.isRegistered<PlantCategoryRepository>()) {
      getIt.registerLazySingleton<PlantCategoryRepository>(
        () => PlantCategoryRepositoryImpl(getIt<NetworkClient>()),
      );
    }
  }

  static void _configureBlocInjection() {
    Bloc.observer = AppBlocObserver();
  }
}
