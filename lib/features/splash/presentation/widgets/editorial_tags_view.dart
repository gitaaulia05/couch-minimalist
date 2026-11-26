import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';

/// Editorial specs detail highlighting materials and craftsmanship principles.
class EditorialTagsView extends StatelessWidget {
  final List<String> specs;

  const EditorialTagsView({
    super.key,
    this.specs = AppStrings.editorialSpecs,
  });

  @override
  Widget build(BuildContext context) {
    if (specs.isEmpty) return const SizedBox.shrink();

    final List<Widget> items = [];
    for (int i = 0; i < specs.length; i++) {
      items.add(
        Text(
          specs[i].toUpperCase(),
          style: AppTypography.labelSpecs,
        ),
      );

      // Add separator dot between items
      if (i < specs.length - 1) {
        items.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: 3.5,
              height: 3.5,
              decoration: const BoxDecoration(
                color: AppColors.secondaryFixedDim,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: items,
    );
  }
}
