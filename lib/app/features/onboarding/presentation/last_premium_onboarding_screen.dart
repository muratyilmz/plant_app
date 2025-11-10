import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/app/features/onboarding/presentation/cubit/on_boarding_manager_cubit.dart';
import 'package:plant_app/app/router/router.dart';
import 'package:plant_app/gen/assets.gen.dart';
import 'package:plant_app/app/core/config/color_config.dart';
import 'package:plant_app/app/core/constants/string_constants.dart';
import 'package:plant_app/app/core/widgets/base_scaffold.dart';
import 'package:plant_app/app/core/widgets/custom_elevated_button.dart';
import 'package:plant_app/app/features/onboarding/presentation/widget/custom_carousel_widget.dart';
import 'package:plant_app/app/features/onboarding/presentation/widget/subscription_option_tile.dart';

class LastPremiumOnboardingScreen extends StatelessWidget {
  const LastPremiumOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Assets.icons.unlimited.svg(height: 36.h),
        title: StringConstants.unlimited,
        subtitle: StringConstants.plantIdentify,
      ),
      (
        icon: Assets.icons.fast.svg(height: 36.h),
        title: StringConstants.faster,
        subtitle: StringConstants.process,
      ),
      (
        icon: Assets.icons.unlimited.svg(height: 36.h),
        title: StringConstants.unlimited,
        subtitle: StringConstants.plantIdentify,
      ),
    ];

    final options = [
      (
        title: StringConstants.oneMounth,
        subtitle: StringConstants.mountAutoRenew,
        badgeText: '',
      ),
      (
        title: StringConstants.oneYear,
        subtitle: StringConstants.firstThereeDays,
        badgeText: StringConstants.save50,
      ),
    ];

    final selectedIndex = ValueNotifier(1);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [Colors.red, Colors.black87],
        ),
        image: DecorationImage(
          image: Assets.images.paywallImage.provider(),
          fit: BoxFit.cover,
        ),
      ),
      child: BaseScaffold(
        child: Stack(
          children: [
            Positioned(
              right: 16.w,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 20.sp),
                ),
              ),
            ),
            Column(
              spacing: 12.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.snowWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.sp,
                    ),
                    children: [
                      TextSpan(text: StringConstants.plantApp),
                      TextSpan(
                        text: StringConstants.premium,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.snowWhite,
                          fontSize: 32.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  StringConstants.accessAllFetures,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.snowWhite,
                    fontWeight: FontWeight.w300,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(
                  height: 124.h,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return CustomCarouselWidget(
                        icon: item.icon,
                        title: item.title,
                        subtitle: item.subtitle,
                        onTap: () {},
                      );
                    },
                  ),
                ),
                ValueListenableBuilder<int>(
                  valueListenable: selectedIndex,
                  builder: (context, current, _) {
                    return Column(
                      children: List.generate(options.length, (index) {
                        final item = options[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SubscriptionOptionTile(
                            title: item.title,
                            subtitle: item.subtitle,
                            isSelected: current == index,
                            badgeText: item.badgeText,
                            onTap: () => selectedIndex.value = index,
                          ),
                        );
                      }),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: CustomElevatedButton(
                      onPressed: () async {
                        try {
                          final onboardingCubit = context
                              .read<OnBoardingManagerCubit>();

                          await onboardingCubit.markCompleted();
                          if (context.mounted) {
                            context.router.pushAndPopUntil(
                              HomeRoute(),
                              predicate: (route) => false,
                            );
                          }

                          if (context.mounted) {
                            final state = onboardingCubit.state;
                            if (state.isCompleted) {}
                          }
                        } catch (e, stackTrace) {
                          debugPrint('LastPremiumOnboardingScreen: Error: $e');
                          debugPrint(
                            'LastPremiumOnboardingScreen: StackTrace: $stackTrace',
                          );

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      child: Text(StringConstants.tryFreeFor),
                    ),
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  StringConstants.afterTheThreeDays,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 8,
                    color: AppColors.snowWhite.withValues(alpha: 0.5),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConstants.terms,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        color: AppColors.snowWhite.withValues(alpha: 0.5),
                      ),
                    ),
                    2.horizontalSpace,
                    Icon(
                      Icons.circle,
                      color: AppColors.snowWhite.withValues(alpha: 0.5),
                      size: 4,
                    ),
                    2.horizontalSpace,
                    Text(
                      StringConstants.privacy,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        color: AppColors.snowWhite.withValues(alpha: 0.5),
                      ),
                    ),
                    2.horizontalSpace,
                    Icon(
                      Icons.circle,
                      color: AppColors.snowWhite.withValues(alpha: 0.5),
                      size: 4,
                    ),
                    2.horizontalSpace,
                    Text(
                      StringConstants.restore,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        color: AppColors.snowWhite.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
