import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/di/dependency_injection.dart';
import 'package:plant_app/app/core/blocs/theme_cubit/theme_cubit.dart';

import 'package:plant_app/app/router/plant_router_observer.dart';
import 'package:plant_app/app/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final AppRouter _appRouter = getIt<AppRouter>();
  static final PlantRouterObserver _routerObserver =
      getIt<PlantRouterObserver>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return ScreenUtilInit(
            builder: (_, _) => MaterialApp.router(
              theme: ThemeData.light(useMaterial3: true),
              darkTheme: ThemeData.dark(useMaterial3: true),
              debugShowCheckedModeBanner: false,
              routerConfig: _appRouter.config(
                navigatorObservers: () => [_routerObserver],
              ),
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(1.0)),
                child: child ?? const SizedBox.shrink(),
              ),

              themeMode: themeState.themeMode,
            ),
          );
        },
      ),
    );
  }
}
