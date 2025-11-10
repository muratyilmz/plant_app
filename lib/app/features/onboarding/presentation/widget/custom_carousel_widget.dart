import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/app/core/config/color_config.dart';

class CustomCarouselWidget extends StatelessWidget {
  const CustomCarouselWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.backgroundColor,
    this.onTap,
  });

  final Widget icon;
  final String title;
  final String subtitle;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16).r,
      onTap: onTap,
      child: Ink(
        width: 150.w,
        padding: EdgeInsets.all(16).r,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.seaGreen2,
          borderRadius: BorderRadius.circular(16).r,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            16.verticalSpace,
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            4.verticalSpace,
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
