import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/di/dependency_injection.dart';
import 'package:plant_app/gen/assets.gen.dart';
import 'package:plant_app/app/core/blocs/theme_cubit/theme_cubit.dart';
import 'package:plant_app/app/core/constants/string_constants.dart';
import 'package:plant_app/app/features/home/domain/repository/article_repository.dart';
import 'package:plant_app/app/features/home/domain/repository/plant_category.repository.dart';
import 'package:plant_app/app/features/home/presentation/blocs/article_bloc/article_bloc.dart';
import 'package:plant_app/app/features/home/presentation/blocs/plant_category/plant_category_bloc.dart';
import 'package:plant_app/app/features/home/presentation/widgets/article_carousel.dart';
import 'package:plant_app/app/features/home/presentation/widgets/category_card.dart';
import 'package:plant_app/app/features/home/presentation/widgets/search_bar_field.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heroHeight = size.height * 0.32;
    final colorScheme = Theme.of(context).colorScheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ArticleBloc(getIt<ArticleRepository>())
                ..add(const ArticleRequested()),
        ),
        BlocProvider(
          create: (context) =>
              PlantCategoryBloc(getIt<PlantCategoryRepository>())
                ..add(PlantCategoryRequested()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: heroHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Assets.images.background.image(fit: BoxFit.cover),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.035),
                            Colors.black.withValues(alpha: 0.014),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ).r,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              BlocBuilder<ThemeCubit, ThemeState>(
                                builder: (context, themeState) {
                                  return IconButton(
                                    icon: Icon(
                                      themeState.isDarkMode
                                          ? Icons.light_mode
                                          : Icons.dark_mode,

                                      color: colorScheme.outline,
                                      size: 24.sp,
                                    ),
                                    onPressed: () {
                                      context.read<ThemeCubit>().toggleTheme();
                                    },
                                    style: IconButton.styleFrom(
                                      backgroundColor: colorScheme
                                          .primaryContainer
                                          .withValues(alpha: 0.8),
                                      shape: const CircleBorder(),
                                      padding: EdgeInsets.all(8.w),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Text(
                            StringConstants.hiPlantLover,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: colorScheme.onSurface),
                          ),
                          Text(
                            StringConstants.goodAfternoon,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          16.verticalSpace,
                          const SearchBarField(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ).r,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Assets.images.premiumBox.image(),
                    16.verticalSpace,

                    BlocBuilder<ArticleBloc, ArticleState>(
                      builder: (context, state) {
                        if (state is ArticleLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is ArticleFailure) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text(
                                state.message,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        } else if (state is ArticleSuccess) {
                          if (state.articles.isEmpty) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Text('No articles found'),
                              ),
                            );
                          }
                          return SizedBox(
                            height: 130.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.articles.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 12.w),
                              itemBuilder: (context, index) {
                                final article = state.articles[index];
                                return SizedBox(
                                  width: 0.6.sw,
                                  child: ArticleCard(
                                    item: CarouselItem(
                                      imageUrl: article.imageUri ?? '',
                                      title: article.title ?? 'No title',
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),

                    BlocBuilder<PlantCategoryBloc, PlantCategoryState>(
                      builder: (context, state) {
                        if (state is PlantCategoryLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is PlantCategoryFailure) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text(
                                state.message,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        } else if (state is PlantCategorySuccess) {
                          if (state.categories.data?.isEmpty ?? true) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Text('No articles found'),
                              ),
                            );
                          }
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.9,
                                ),
                            itemCount: state.categories.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final category = state.categories.data?[index];
                              return CategoryCard(
                                imageHeight: category?.image?.height
                                    ?.toDouble(),
                                imageWidth: category?.image?.width?.toDouble(),
                                title: category?.title ?? '',
                                imageUrl: category?.image?.url ?? '',
                              );
                            },
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
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
