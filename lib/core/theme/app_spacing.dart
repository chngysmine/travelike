import 'package:flutter/material.dart';

/// Standardized spacing system based on a 4px grid.
/// Replaces inconsistent padding/margin values across all screens.
class AppSpacing {
  AppSpacing._();

  // ==================== BASE UNITS ====================
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 40;
  static const double massive = 48;

  // ==================== SCREEN PADDING ====================
  /// Standard horizontal padding for all screens
  static const EdgeInsets screenH = EdgeInsets.symmetric(horizontal: 20);

  /// Full screen padding (horizontal + top)
  static const EdgeInsets screen = EdgeInsets.fromLTRB(20, 16, 20, 0);

  /// Screen padding with bottom space for bottom nav
  static const EdgeInsets screenWithNav = EdgeInsets.fromLTRB(20, 16, 20, 100);

  // ==================== CARD PADDING ====================
  /// Standard card internal padding
  static const EdgeInsets card = EdgeInsets.all(16);

  /// Compact card padding
  static const EdgeInsets cardCompact = EdgeInsets.all(12);

  /// Large card padding (for detail screens)
  static const EdgeInsets cardLarge = EdgeInsets.all(20);

  // ==================== GAPS ====================
  /// Gap between major sections (e.g., header → content)
  static const double sectionGap = 24;

  /// Gap between sub-sections
  static const double subsectionGap = 16;

  /// Gap between list/grid items
  static const double itemGap = 12;

  /// Gap between inline elements (icon + text)
  static const double inlineGap = 8;

  /// Tiny gap (between label and value)
  static const double tinyGap = 4;

  // ==================== BORDER RADIUS ====================
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusXxl = 24;
  static const double radiusRound = 30;
  static const double radiusFull = 999;

  // ==================== CONVENIENCE WIDGETS ====================
  static const SizedBox vXs = SizedBox(height: xs);
  static const SizedBox vSm = SizedBox(height: sm);
  static const SizedBox vMd = SizedBox(height: md);
  static const SizedBox vLg = SizedBox(height: lg);
  static const SizedBox vXl = SizedBox(height: xl);
  static const SizedBox vXxl = SizedBox(height: xxl);
  static const SizedBox vXxxl = SizedBox(height: xxxl);
  static const SizedBox vSection = SizedBox(height: sectionGap);

  static const SizedBox hXs = SizedBox(width: xs);
  static const SizedBox hSm = SizedBox(width: sm);
  static const SizedBox hMd = SizedBox(width: md);
  static const SizedBox hLg = SizedBox(width: lg);
  static const SizedBox hXl = SizedBox(width: xl);

  // ==================== COMMON BORDER RADII ====================
  static final BorderRadius borderSm = BorderRadius.circular(radiusSm);
  static final BorderRadius borderMd = BorderRadius.circular(radiusMd);
  static final BorderRadius borderLg = BorderRadius.circular(radiusLg);
  static final BorderRadius borderXl = BorderRadius.circular(radiusXl);
  static final BorderRadius borderXxl = BorderRadius.circular(radiusXxl);
  static final BorderRadius borderRound = BorderRadius.circular(radiusRound);

  // ==================== SHADOWS ====================
  static List<BoxShadow> get shadowSm => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMd => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLg => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get shadowXl => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 28,
          offset: const Offset(0, 12),
        ),
      ];

  /// Colored shadow for primary elements (buttons, FABs)
  static List<BoxShadow> shadowPrimary(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];
}
