import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';

/// Top subtle status indicator showing design studio origin and aesthetic zen symbol.
class TopIndicatorBar extends StatelessWidget {
  final String originText;

  const TopIndicatorBar({
    super.key,
    this.originText = AppStrings.originIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Opacity(
        opacity: 0.50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Origin Label with indicator dot
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  originText.toUpperCase(),
                  style: AppTypography.labelOrigin,
                ),
              ],
            ),

            // Right Zen Icon
            const Icon(
              Icons.spa_outlined,
              size: 18,
              color: AppColors.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
