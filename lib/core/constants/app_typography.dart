import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography definitions based on Plus Jakarta Sans.
class AppTypography {
  AppTypography._();

  static TextStyle get headlineBrand => GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: 6.0, // tracking-[0.22em]
        color: AppColors.primary,
      );

  static TextStyle get bodyTagline => GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.6,
        letterSpacing: 0.0,
        color: AppColors.secondary,
      );

  static TextStyle get labelOrigin => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.5,
        color: AppColors.secondary,
      );

  static TextStyle get labelSpecs => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.4,
        color: AppColors.secondaryFixedDim,
      );

  static TextStyle get labelBrandMeta => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
        color: AppColors.secondary,
      );

  static TextStyle get labelVersion => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.0,
        color: AppColors.secondary,
      );
}
