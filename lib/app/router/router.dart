import 'package:auto_route/auto_route.dart';
import 'package:plant_app/app/features/home/presentation/home_screen.dart';
import 'package:plant_app/app/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:plant_app/app/features/onboarding/presentation/onboarding_builder_screen.dart';
import 'package:plant_app/app/features/onboarding/presentation/welcome_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: WelcomeRoute.page, initial: true),
    AutoRoute(page: OnboardingBuilderRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: BottomNavigationBarRoute.page),
  ];
}
