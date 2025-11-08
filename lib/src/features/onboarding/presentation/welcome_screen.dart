import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/gen/assets.gen.dart';
import 'package:plant_app/src/core/config/color_config.dart';
import 'package:plant_app/src/core/constants/string_constants.dart';
import 'package:plant_app/src/core/widgets/base_scaffold.dart';
import 'package:plant_app/src/core/widgets/custom_elevated_button.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      useSafeArea: true,
      background: Assets.images.bgImg.image(
        fit: BoxFit.cover,
        height: 1.sh,
        width: 1.sw,
      ),

      child: Center(
        child: SingleChildScrollView(
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

              CustomElevatedButton(
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
        ),
      ),
    );
  }
}
