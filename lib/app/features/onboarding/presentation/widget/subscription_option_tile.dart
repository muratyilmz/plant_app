import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_app/app/core/config/color_config.dart';

class SubscriptionOptionTile extends StatelessWidget {
  const SubscriptionOptionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    this.onTap,
    this.badgeText,
    this.selectedColor,
    this.unselectedColor,
    this.badgeColor,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback? onTap;
  final String? badgeText;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? badgeColor;

  bool get _showBadge => isSelected && (badgeText?.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = unselectedColor ?? AppColors.seaGreen2;
    final borderColor = isSelected
        ? (selectedColor ?? AppColors.semanticGreen)
        : Colors.transparent;
    final textColor = Colors.white;

    return InkWell(
      borderRadius: BorderRadius.circular(20).r,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14).r,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20).r,
          border: Border.all(color: borderColor, width: 2.r),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _RadioDot(isSelected: isSelected),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: textColor.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (_showBadge)
              Positioned(
                right: -18,
                top: -14,
                child: _DiscountBadge(
                  text: badgeText!,
                  color: badgeColor ?? AppColors.semanticGreen,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? AppColors.semanticGreen
            : AppColors.seaGreen.withValues(alpha: 0.25),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? AppColors.snowWhite : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4).r,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(2).r,
          bottomLeft: Radius.circular(16).r,
          bottomRight: Radius.circular(4).r,
          topRight: Radius.circular(16).r,
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
