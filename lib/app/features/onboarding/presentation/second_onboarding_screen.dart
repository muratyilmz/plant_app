import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/gen/assets.gen.dart';
import 'package:plant_app/app/core/constants/string_constants.dart';
import 'package:plant_app/app/core/widgets/base_scaffold.dart';
import 'package:plant_app/app/core/widgets/custom_elevated_button.dart';
import 'package:plant_app/app/features/onboarding/presentation/cubit/on_boarding_manager_cubit.dart';

class SecondOnboardingScreen extends StatelessWidget {
  const SecondOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = context.read<OnBoardingManagerCubit>();
    return BaseScaffold(
      useSafeArea: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Assets.images.getPlantCareGuides.svg(
            height: 0.15.sh,

            fit: BoxFit.contain,
          ),
          Spacer(),
          Assets.images.plantDetailOnboarding.image(
            height: 0.55.sh,
            fit: BoxFit.scaleDown,
          ),

          CustomElevatedButton(
            onPressed: () => onboardingCubit.nextPage(),
            child: Text(StringConstants.continueButton),
          ),
        ],
      ),
    );
  }
}
