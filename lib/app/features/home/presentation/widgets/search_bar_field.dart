import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/app/core/config/color_config.dart';

class SearchBarField extends StatelessWidget {
  const SearchBarField({
    super.key,
    this.controller,
    this.hintText = 'Search for plants',
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.backgroundColor,
    this.borderRadius = 16,
    this.elevation = 2,
    this.textInputAction = TextInputAction.search,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
  });

  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final double borderRadius;
  final double elevation;
  final TextInputAction textInputAction;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.seaGreen.withValues(alpha: 0.6),
          ),
          prefixIcon:
              prefixIcon ?? const Icon(Icons.search, color: Colors.grey),
          fillColor: backgroundColor ?? Colors.white,
          filled: true,
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16).r,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16).r,
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
