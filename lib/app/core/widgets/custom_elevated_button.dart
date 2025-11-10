import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/app/core/config/color_config.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, this.onPressed, required this.child});

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.all(20.r)),
              backgroundColor: WidgetStateProperty.all(AppColors.semanticGreen),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              textStyle: WidgetStateProperty.all(
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
