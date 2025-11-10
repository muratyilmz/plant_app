import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/di/dependency_injection.dart';
import 'package:plant_app/app/features/onboarding/presentation/cubit/on_boarding_manager_cubit.dart';
import 'package:plant_app/app/features/onboarding/presentation/first_onboarding_screen.dart';
import 'package:plant_app/app/features/onboarding/presentation/last_premium_onboarding_screen.dart';
import 'package:plant_app/app/features/onboarding/presentation/second_onboarding_screen.dart';
import 'package:plant_app/app/router/router.dart';

@RoutePage()
class OnboardingBuilderScreen extends StatefulWidget {
  const OnboardingBuilderScreen({super.key});

  @override
  State<OnboardingBuilderScreen> createState() =>
      _OnboardingBuilderScreenState();
}

class _OnboardingBuilderScreenState extends State<OnboardingBuilderScreen> {
  late final PageController _pageController;
  final List<Widget> _pages = const [
    FirstOnboardingScreen(),
    SecondOnboardingScreen(),
    LastPremiumOnboardingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goTo(int page) async {
    if (!_pageController.hasClients) return;
    await _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnBoardingManagerCubit>(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<OnBoardingManagerCubit>();

          return BlocListener<OnBoardingManagerCubit, OnBoardingManagerState>(
            listenWhen: (previous, current) =>
                previous.isCompleted != current.isCompleted,
            listener: (context, state) {
              if (state.isCompleted && context.mounted) {
                debugPrint('Onboarding completed, navigating to home');
                context.router.push(const BottomNavigationBarRoute());
              }
            },
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child:
                        BlocListener<
                          OnBoardingManagerCubit,
                          OnBoardingManagerState
                        >(
                          listenWhen: (previous, current) =>
                              previous.currentPage != current.currentPage,
                          listener: (_, state) => _goTo(state.currentPage),
                          child: PageView.builder(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _pages.length,
                            onPageChanged: cubit.setPage,
                            itemBuilder: (context, index) => _pages[index],
                          ),
                        ),
                  ),
                  BlocBuilder<OnBoardingManagerCubit, OnBoardingManagerState>(
                    builder: (context, state) {
                      if (cubit.isLastPage) {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16).r,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(state.pageCount, (index) {
                                final isActive = index == state.currentPage;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  width: isActive ? 12.w : 8.w,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isActive
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.primary
                                              .withValues(alpha: 0.3),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
