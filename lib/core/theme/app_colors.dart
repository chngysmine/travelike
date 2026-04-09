import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Palette - Vietnamese Marsala
  static const Color primary = Color(0xFF8B4049);
  static const Color primaryLight = Color(0xFFC4776E);
  static const Color primaryDark = Color(0xFF5E2A31);
  static const Color primarySurface = Color(0xFFFFF0ED);

  // Accent Colors
  static const Color accentRed = Color(0xFFCC2222);
  static const Color accentGold = Color(0xFFD4A853);
  static const Color accentTeal = Color(0xFF2ABFBF);

  // Neutral Colors
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Background Colors
  static const Color backgroundLight = Color(0xFFFFFBF7);
  static const Color backgroundCard = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF1A1A2E);

  // Gradient Colors (Signature pastel gradient)
  static const Color gradientTop = Color(0xFFFFFDF9);
  static const Color gradientMiddle = Color(0xFFFFF0E6);
  static const Color gradientPink = Color(0xFFF5D5D5);
  static const Color gradientBlue = Color(0xFFE8EDF5);
  static const Color gradientBottom = Color(0xFFF0F4F8);

  // Status Colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Category Colors
  static const Color categoryFood = Color(0xFFE74C3C);
  static const Color categoryBeach = Color(0xFF3498DB);
  static const Color categoryMountain = Color(0xFF27AE60);
  static const Color categoryCulture = Color(0xFF9B59B6);
  static const Color categoryNightlife = Color(0xFFF39C12);

  // Interest Chips
  static const Color chipGreen = Color(0xFF10B981);
  static const Color chipRed = Color(0xFFEF4444);
  static const Color chipOrange = Color(0xFFF97316);
  static const Color chipPurple = Color(0xFF8B5CF6);
  static const Color chipBlue = Color(0xFF3B82F6);
  static const Color chipTeal = Color(0xFF14B8A6);

  // Signature gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientTop, gradientMiddle, gradientPink, gradientBlue, gradientBottom],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00FFFFFF), Color(0xCC000000)],
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFF9A76), Color(0xFFBB4E75), Color(0xFF6E3667)],
  );
}
