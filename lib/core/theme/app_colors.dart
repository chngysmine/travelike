import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ==================== PRIMARY PALETTE — Vietnamese Marsala ====================
  static const Color primary = Color(0xFF8B4049);
  static const Color primaryLight = Color(0xFFC4776E);
  static const Color primaryDark = Color(0xFF5E2A31);
  static const Color primarySurface = Color(0xFFFFF0ED);

  // ==================== ACCENT COLORS ====================
  static const Color accentRed = Color(0xFFCC2222);
  static const Color accentGold = Color(0xFFD4A853);
  static const Color accentTeal = Color(0xFF2ABFBF);

  // ==================== NEUTRAL / TEXT ====================
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textWhite = Color(0xFFFFFFFF);

  // ==================== BACKGROUND ====================
  static const Color backgroundLight = Color(0xFFFFFBF7);
  static const Color backgroundCard = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF1A1A2E);

  // ==================== GRADIENT PRIMITIVES ====================
  static const Color gradientTop = Color(0xFFFFFDF9);
  static const Color gradientMiddle = Color(0xFFFFF0E6);
  static const Color gradientPink = Color(0xFFF5D5D5);
  static const Color gradientBlue = Color(0xFFE8EDF5);
  static const Color gradientBottom = Color(0xFFF0F4F8);

  // ==================== STATUS ====================
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ==================== CATEGORY ====================
  static const Color categoryFood = Color(0xFFE74C3C);
  static const Color categoryBeach = Color(0xFF3498DB);
  static const Color categoryMountain = Color(0xFF27AE60);
  static const Color categoryCulture = Color(0xFF9B59B6);
  static const Color categoryNightlife = Color(0xFFF39C12);

  // ==================== CHIP / TAG ====================
  static const Color chipGreen = Color(0xFF10B981);
  static const Color chipRed = Color(0xFFEF4444);
  static const Color chipOrange = Color(0xFFF97316);
  static const Color chipPurple = Color(0xFF8B5CF6);
  static const Color chipBlue = Color(0xFF3B82F6);
  static const Color chipTeal = Color(0xFF14B8A6);

  // ==================== LIQUID GLASS TOKENS ====================
  /// Glass surface — white with 70% opacity
  static const Color glassWhite = Color(0xB3FFFFFF);
  /// Glass surface — lighter variant (85%)
  static const Color glassWhiteLight = Color(0xD9FFFFFF);
  /// Glass surface — heavier variant (50%)
  static const Color glassWhiteMedium = Color(0x80FFFFFF);
  /// Glass border highlight
  static const Color glassBorder = Color(0x33FFFFFF);
  /// Glass border on light backgrounds
  static const Color glassBorderLight = Color(0x1AFFFFFF);
  /// Dark glass surface
  static const Color glassDark = Color(0x661A1A2E);
  /// Dark glass border
  static const Color glassDarkBorder = Color(0x33000000);

  /// Standard blur sigma for glass effects
  static const double glassBlurLight = 10.0;
  static const double glassBlurMedium = 20.0;
  static const double glassBlurHeavy = 30.0;

  // ==================== OVERLAY ====================
  static const Color overlayDark = Color(0x80000000);
  static const Color overlayLight = Color(0x40FFFFFF);
  static const Color overlayScrim = Color(0x4D000000);

  // ==================== SHADOWS ====================
  static List<BoxShadow> get glassShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.02),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> primaryShadow([double opacity = 0.3]) => [
        BoxShadow(
          color: primary.withValues(alpha: opacity),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];

  // ==================== GRADIENTS ====================
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

  /// Glass gradient overlay — subtle warm tint
  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x1AFFFFFF), Color(0x0DFFF0ED)],
  );

  /// Dark glass gradient
  static const LinearGradient glassDarkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x331A1A2E), Color(0x1A000000)],
  );

  /// Shimmer gradient for loading states
  static const LinearGradient shimmerGradient = LinearGradient(
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    colors: [Color(0xFFEEEEEE), Color(0xFFF5F5F5), Color(0xFFEEEEEE)],
    stops: [0.0, 0.5, 1.0],
  );
}
