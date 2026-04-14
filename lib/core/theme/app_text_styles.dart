import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography tokens for the entire Travelike app.
/// Eliminates scattered GoogleFonts calls and enforces visual consistency.
class AppTextStyles {
  AppTextStyles._();

  // ==================== DISPLAY (Playfair Display — Serif) ====================
  /// Screen titles, hero text — 32px Bold
  static TextStyle get displayLarge => GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  /// Section headers, modal titles — 24px Bold
  static TextStyle get displayMedium => GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  /// Sub-section headers — 20px Bold
  static TextStyle get displaySmall => GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  // ==================== TITLE (Inter — Sans-serif) ====================
  /// Card titles, prominent labels — 18px SemiBold
  static TextStyle get titleLarge => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// List item titles — 16px SemiBold
  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Small titles, tab labels — 14px SemiBold
  static TextStyle get titleSmall => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // ==================== BODY (Inter — Regular) ====================
  /// Primary body text — 15px Regular
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  /// Standard body text — 14px Regular
  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  /// Small body text — 13px Regular
  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  // ==================== LABEL (Inter — Medium/SemiBold) ====================
  /// Button text — 16px SemiBold
  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  /// Chip text, small buttons — 13px SemiBold
  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Captions, timestamps, metadata — 11px Medium
  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiary,
      );

  // ==================== SPECIAL ====================
  /// Price text — 22px Bold
  static TextStyle get price => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );

  /// Rating text — 14px SemiBold
  static TextStyle get rating => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Badge/tag text — 10px SemiBold
  static TextStyle get badge => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  /// Hero welcome text — 56px Bold, gold
  static TextStyle get hero => GoogleFonts.playfairDisplay(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: AppColors.accentGold,
        letterSpacing: 2,
      );

  /// App brand text — 18px ExtraBold
  static TextStyle get brand => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: 8,
      );
}

/// Extension for convenient color overrides without redefining entire style.
extension TextStyleColor on TextStyle {
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get secondary => copyWith(color: AppColors.textSecondary);
  TextStyle get tertiary => copyWith(color: AppColors.textTertiary);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get white70 => copyWith(color: Colors.white70);
  TextStyle get onDark => copyWith(color: Colors.white);
  TextStyle get gold => copyWith(color: AppColors.accentGold);
  TextStyle get error => copyWith(color: AppColors.error);
  TextStyle get success => copyWith(color: AppColors.chipGreen);
}
