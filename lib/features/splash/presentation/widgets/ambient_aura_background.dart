import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Ambient organic background aura gradients that produce the soft Japandi/Nordic atmosphere.
class AmbientAuraBackground extends StatefulWidget {
  final bool isExpanded;

  const AmbientAuraBackground({
    super.key,
    required this.isExpanded,
  });

  @override
  State<AmbientAuraBackground> createState() => _AmbientAuraBackgroundState();
}

class _AmbientAuraBackgroundState extends State<AmbientAuraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Subtle, slow breathing rhythm for the central aura
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.05).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            // 1. Top-Right Warm Sand Diffusion
            Positioned(
              top: -80,
              right: -60,
              child: _BlurredCircle(
                size: 300,
                color: AppColors.secondaryContainer.withValues(alpha: 0.40),
                blurRadius: 60,
              ),
            ),

            // 2. Central Warm Terracotta Glow (Ethereal Breathing Aura)
            Center(
              child: AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  final scaleMultiplier =
                      widget.isExpanded ? 1.25 : _pulseAnimation.value;
                  return AnimatedScale(
                    scale: scaleMultiplier,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    child: child,
                  );
                },
                child: _BlurredCircle(
                  size: 260,
                  color: AppColors.onTertiaryContainer.withValues(alpha: 0.12),
                  blurRadius: 70,
                ),
              ),
            ),

            // 3. Bottom-Left Low Warmth Shade
            Positioned(
              bottom: -90,
              left: -70,
              child: _BlurredCircle(
                size: 320,
                color: AppColors.surfaceContainerHigh.withValues(alpha: 0.60),
                blurRadius: 65,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlurredCircle extends StatelessWidget {
  final double size;
  final Color color;
  final double blurRadius;

  const _BlurredCircle({
    required this.size,
    required this.color,
    required this.blurRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurRadius, sigmaY: blurRadius),
        child: const SizedBox.shrink(),
      ),
    );
  }
}
