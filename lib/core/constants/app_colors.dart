import 'package:flutter/material.dart';

/// AppColors encapsulates all color tokens derived from the design system.
/// Values directly mirror the Tailwind CSS configuration for the SOFI brand.
class AppColors {
  AppColors._();

  // Core Brand Colors
  static const Color primary = Color(0xFF040505);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF1E1E1E);

  // Surface & Backgrounds
  static const Color surface = Color(0xFFFBF9F5);
  static const Color background = Color(0xFFFBF9F5);
  static const Color onSurface = Color(0xFF1B1C1A);
  static const Color onBackground = Color(0xFF1B1C1A);

  // Surface Containers
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF5F3EF);
  static const Color surfaceContainer = Color(0xFFEFEEEA);
  static const Color surfaceContainerHigh = Color(0xFFEAE8E4);
  static const Color surfaceContainerHighest = Color(0xFFE4E2DE);
  static const Color surfaceVariant = Color(0xFFE4E2DE);

  // Secondary Neutrals
  static const Color secondary = Color(0xFF645D55);
  static const Color secondaryContainer = Color(0xFFE8DED3);
  static const Color secondaryFixed = Color(0xFFEAE1D6);
  static const Color secondaryFixedDim = Color(0xFFCEC5BA);

  // Terracotta & Warm Accents
  static const Color onTertiaryContainer = Color(0xFFC07249);
  static const Color terracottaStart = Color(0xFFBD714A);
  static const Color terracottaEnd = Color(0xFFA85C36);
  static const Color tertiaryFixed = Color(0xFFFFDBCB);
  static const Color tertiaryFixedDim = Color(0xFFFFB692);

  // Outlines & Borders
  static const Color outline = Color(0xFF747878);
  static const Color outlineVariant = Color(0xFFC4C7C7);
}
