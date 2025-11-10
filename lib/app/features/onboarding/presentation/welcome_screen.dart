import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/app/features/onboarding/presentation/cubit/on_boarding_manager_cubit.dart';
import 'package:plant_app/di/dependency_injection.dart';
import 'package:plant_app/gen/assets.gen.dart';
import 'package:plant_app/app/core/config/color_config.dart';
import 'package:plant_app/app/core/constants/string_constants.dart';
import 'package:plant_app/app/core/widgets/base_scaffold.dart';
import 'package:plant_app/app/core/widgets/custom_elevated_button.dart';
import 'package:plant_app/app/router/router.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isCheckingOnboarding = true;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    try {
      final onboardingCubit = getIt<OnBoardingManagerCubit>();

      final isCompleted = await onboardingCubit.isOnboardingCompleted();

      if (mounted) {
        setState(() {
          _isCheckingOnboarding = false;
        });

        if (isCompleted) {
          await Future.delayed(const Duration(milliseconds: 100));

          if (mounted) {
            context.router.push(const BottomNavigationBarRoute());
          }
        } else {
          debugPrint(
            'WelcomeScreen: Onboarding not completed, staying on welcome screen',
          );
        }
      }
    } catch (e, stackTrace) {
      debugPrint('WelcomeScreen: Error checking onboarding status: $e');
      debugPrint('WelcomeScreen: StackTrace: $stackTrace');

      if (mounted) {
        setState(() {
          _isCheckingOnboarding = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingOnboarding) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return BaseScaffold(
      useSafeArea: true,
      background: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.bgImg.provider(),
            fit: BoxFit.cover,
          ),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12.h,
        children: [
          Assets.images.welcomeToPlantText.svg(
            height: 0.12.sh,
            fit: BoxFit.contain,
          ),
          Assets.images.welcomeOnboardingPlant.image(
            height: 0.53.sh,
            fit: BoxFit.fitHeight,
          ),
          Spacer(),

          CustomElevatedButton(
            onPressed: () => context.router.push(OnboardingBuilderRoute()),
            child: Text(StringConstants.getStartedButton),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 10.sp,
                color: AppColors.greyTextColor,
              ),

              children: [
                TextSpan(text: StringConstants.onboardingAgreementPrefix),
                const TextSpan(text: '\n'),
                TextSpan(
                  text: StringConstants.onboardingAgreementLink,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 10.sp,
                    decoration: TextDecoration.underline,
                    color: AppColors.greyTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
