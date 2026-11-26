import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_typography.dart';
import 'sofa_icon_painter.dart';

/// Central Brand Identity section containing the terracotta squircle logo,
/// animated vector sofa icon, and brand typography.
class BrandIdentityView extends StatefulWidget {
  final String appName;
  final String tagline;
  final ValueChanged<bool>? onTactileInteraction;

  const BrandIdentityView({
    super.key,
    this.appName = AppStrings.appName,
    this.tagline = AppStrings.brandTagline,
    this.onTactileInteraction,
  });

  @override
  State<BrandIdentityView> createState() => _BrandIdentityViewState();
}

class _BrandIdentityViewState extends State<BrandIdentityView> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails _) {
    setState(() => _isPressed = true);
    widget.onTactileInteraction?.call(true);
  }

  void _handleTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
    widget.onTactileInteraction?.call(false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    widget.onTactileInteraction?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Tactile Terracotta Squircle Icon Container
        GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: AnimatedScale(
            scale: _isPressed ? 0.94 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glow Underlay
                Container(
                  width: 104,
                  height: 104,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.onTertiaryContainer
                            .withValues(alpha: 0.35),
                        blurRadius: 28,
                        spreadRadius: 2,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ),

                // Main Squircle Frame
                Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.terracottaStart,
                        AppColors.terracottaEnd,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            AppColors.terracottaEnd.withValues(alpha: 0.40),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Inner Sofa Vector Illustration
                      const SizedBox(
                        width: 64,
                        height: 64,
                        child: CustomPaint(
                          painter: SofaIconPainter(color: Colors.white),
                        ),
                      ),

                      // Glass Sheen Diagonal Glint
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.white.withValues(alpha: 0.0),
                                Colors.white.withValues(alpha: 0.16),
                                Colors.white.withValues(alpha: 0.0),
                              ],
                              stops: const [0.15, 0.50, 0.85],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 32),

        // 2. Brand Name Typography
        Padding(
          padding: const EdgeInsets.only(left: 6.0), // balances optical tracking
          child: Text(
            widget.appName.toUpperCase(),
            style: AppTypography.headlineBrand,
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 10),

        // 3. Japandi Minimalist Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 260),
          child: Text(
            widget.tagline,
            style: AppTypography.bodyTagline,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
