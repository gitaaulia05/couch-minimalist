import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';

/// Bottom fluid terracotta micro-progress bar and minimalist brand meta footer.
class FluidProgressBar extends StatelessWidget {
  final double progress;
  final String brandMetaTitle;
  final String version;

  const FluidProgressBar({
    super.key,
    required this.progress,
    this.brandMetaTitle = AppStrings.brandMetaTitle,
    this.version = AppStrings.appVersion,
  });

  @override
  Widget build(BuildContext context) {
    const double barWidth = 96.0;
    const double barHeight = 4.0;
    final double clampedProgress = progress.clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Fluid Terracotta Micro-Progress Bar
        Container(
          width: barWidth,
          height: barHeight,
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(barHeight),
          ),
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            width: barWidth * clampedProgress,
            height: barHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(barHeight),
              gradient: const LinearGradient(
                colors: [
                  AppColors.onTertiaryContainer,
                  AppColors.onTertiaryContainer,
                  AppColors.secondary,
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 14),

        // Brand Meta & App Version Information
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              brandMetaTitle.toUpperCase(),
              style: AppTypography.labelBrandMeta,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                '•',
                style: TextStyle(
                  color: AppColors.outlineVariant,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              version,
              style: AppTypography.labelVersion,
            ),
          ],
        ),
      ],
    );
  }
}
