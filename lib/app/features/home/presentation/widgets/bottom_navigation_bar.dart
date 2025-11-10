import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:plant_app/app/core/config/color_config.dart';
import 'package:plant_app/app/features/home/presentation/others_screen/diagnose_screen.dart';
import 'package:plant_app/app/features/home/presentation/home_screen.dart';
import 'package:plant_app/app/features/home/presentation/others_screen/my_garden_screen.dart';
import 'package:plant_app/app/features/home/presentation/others_screen/profile_screen.dart';
import 'package:plant_app/app/features/home/presentation/others_screen/scan_screen.dart';

@RoutePage()
class BottomNavigationBarScreen extends StatelessWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) => PersistentTabView(
    tabs: [
      PersistentTabConfig(
        navigatorConfig: NavigatorConfig(initialRoute: 'Home'),
        screen: HomeScreen(),
        item: ItemConfig(
          icon: Icon(Icons.home),
          title: "Home",
          inactiveForegroundColor: Theme.of(context).colorScheme.secondary,

          activeForegroundColor: AppColors.semanticGreen,
        ),
      ),
      PersistentTabConfig(
        screen: DiagnoseScreen(),
        item: ItemConfig(
          icon: Icon(Icons.health_and_safety_sharp),
          title: "Diagnose",
          inactiveForegroundColor: Theme.of(context).colorScheme.secondary,
          activeForegroundColor: AppColors.semanticGreen,
        ),
      ),
      PersistentTabConfig(
        screen: IdentifyScreen(),
        item: ItemConfig(
          icon: Icon(Icons.qr_code),
          activeForegroundColor: AppColors.semanticGreen,

          inactiveForegroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      PersistentTabConfig(
        screen: MyGardenScreen(),
        item: ItemConfig(
          icon: Icon(Icons.local_florist_rounded),
          title: "My Garden",
          inactiveForegroundColor: Theme.of(context).colorScheme.secondary,
          activeForegroundColor: AppColors.semanticGreen,
        ),
      ),
      PersistentTabConfig(
        screen: ProfileScreen(),
        item: ItemConfig(
          icon: Icon(Icons.person),
          title: "Profile",
          inactiveForegroundColor: Theme.of(context).colorScheme.secondary,
          activeForegroundColor: AppColors.semanticGreen,
        ),
      ),
    ],
    navBarBuilder: (navBarConfig) =>
        Style13BottomNavBar(navBarConfig: navBarConfig),
  );
}
