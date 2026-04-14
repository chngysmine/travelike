import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Standardized animation presets for consistent motion across the app.
class AppAnimations {
  AppAnimations._();

  // ==================== DURATIONS ====================
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration entrance = Duration(milliseconds: 400);

  // ==================== STAGGER DELAYS ====================
  static const Duration staggerDelay = Duration(milliseconds: 60);

  static Duration stagger(int index) => Duration(milliseconds: index * 60);
  static Duration staggerSlow(int index) => Duration(milliseconds: index * 100);

  // ==================== CURVES ====================
  static const Curve defaultCurve = Curves.easeOutCubic;
  static const Curve bounceCurve = Curves.easeOutBack;
  static const Curve sharpCurve = Curves.easeOutQuart;
}

/// Extension methods on Widget for standardized animations.
extension AppAnimateExtension on Widget {
  /// Standard fade-in entrance (for individual elements)
  Widget fadeInUp({int index = 0, Duration? delay}) {
    return animate()
        .fadeIn(
          duration: AppAnimations.entrance,
          delay: delay ?? AppAnimations.stagger(index),
          curve: AppAnimations.defaultCurve,
        )
        .slideY(
          begin: 0.04,
          end: 0,
          duration: AppAnimations.entrance,
          delay: delay ?? AppAnimations.stagger(index),
          curve: AppAnimations.defaultCurve,
        );
  }

  /// Fade in from left (for list items)
  Widget fadeInLeft({int index = 0}) {
    return animate()
        .fadeIn(
          duration: AppAnimations.entrance,
          delay: AppAnimations.stagger(index),
          curve: AppAnimations.defaultCurve,
        )
        .slideX(
          begin: 0.04,
          end: 0,
          duration: AppAnimations.entrance,
          delay: AppAnimations.stagger(index),
          curve: AppAnimations.defaultCurve,
        );
  }

  /// Scale + fade for cards and grid items
  Widget fadeInScale({int index = 0, Duration? delay}) {
    return animate()
        .fadeIn(
          duration: AppAnimations.entrance,
          delay: delay ?? AppAnimations.stagger(index),
          curve: AppAnimations.defaultCurve,
        )
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1.0, 1.0),
          duration: AppAnimations.entrance,
          delay: delay ?? AppAnimations.stagger(index),
          curve: AppAnimations.defaultCurve,
        );
  }

  /// Simple fade in without movement
  Widget fadeInSimple({int index = 0, Duration? delay}) {
    return animate().fadeIn(
      duration: AppAnimations.entrance,
      delay: delay ?? AppAnimations.stagger(index),
      curve: AppAnimations.defaultCurve,
    );
  }

  /// Hero entrance — larger scale + slower
  Widget heroEntrance() {
    return animate()
        .fadeIn(duration: AppAnimations.slow, curve: AppAnimations.defaultCurve)
        .scale(
          begin: const Offset(0.85, 0.85),
          end: const Offset(1.0, 1.0),
          duration: AppAnimations.slow,
          curve: AppAnimations.bounceCurve,
        );
  }

  /// Bounce in (for success indicators, badges)
  Widget bounceIn({Duration? delay}) {
    return animate()
        .fadeIn(duration: AppAnimations.normal, delay: delay)
        .scale(
          begin: const Offset(0.5, 0.5),
          end: const Offset(1.0, 1.0),
          duration: AppAnimations.slow,
          delay: delay,
          curve: Curves.elasticOut,
        );
  }
}
