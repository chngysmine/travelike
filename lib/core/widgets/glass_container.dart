import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A premium frosted-glass container widget implementing the "Liquid Glass" aesthetic.
/// Used as the foundation for cards, navigation bars, modals, and overlays.
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final AlignmentGeometry? alignment;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 20,
    this.blur = AppColors.glassBlurLight,
    this.backgroundColor = AppColors.glassWhite,
    this.borderColor,
    this.borderWidth = 1,
    this.gradient,
    this.boxShadow,
    this.alignment,
  });

  /// Light glass — subtle frosted white surface
  factory GlassContainer.light({
    Key? key,
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double borderRadius = 20,
    List<BoxShadow>? boxShadow,
  }) {
    return GlassContainer(
      key: key,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      blur: AppColors.glassBlurLight,
      backgroundColor: AppColors.glassWhiteLight,
      borderColor: AppColors.glassBorder,
      gradient: AppColors.glassGradient,
      boxShadow: boxShadow ?? AppColors.glassShadow,
      child: child,
    );
  }

  /// Medium glass — balanced frosted surface
  factory GlassContainer.medium({
    Key? key,
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double borderRadius = 20,
    List<BoxShadow>? boxShadow,
  }) {
    return GlassContainer(
      key: key,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      blur: AppColors.glassBlurMedium,
      backgroundColor: AppColors.glassWhite,
      borderColor: AppColors.glassBorder,
      gradient: AppColors.glassGradient,
      boxShadow: boxShadow ?? AppColors.glassShadow,
      child: child,
    );
  }

  /// Dark glass — for use on light images/backgrounds
  factory GlassContainer.dark({
    Key? key,
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double borderRadius = 20,
  }) {
    return GlassContainer(
      key: key,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      blur: AppColors.glassBlurMedium,
      backgroundColor: AppColors.glassDark,
      borderColor: AppColors.glassDarkBorder,
      gradient: AppColors.glassDarkGradient,
      child: child,
    );
  }

  /// Solid surface — no blur, just styled container (for performance-sensitive areas)
  factory GlassContainer.solid({
    Key? key,
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double borderRadius = 20,
    Color color = Colors.white,
    List<BoxShadow>? boxShadow,
  }) {
    return GlassContainer(
      key: key,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      blur: 0,
      backgroundColor: color,
      borderColor: Colors.grey.withValues(alpha: 0.1),
      boxShadow: boxShadow ?? AppColors.cardShadow,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: gradient,
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        boxShadow: boxShadow,
      ),
      child: child,
    );

    if (blur > 0) {
      return Container(
        margin: margin,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: content,
          ),
        ),
      );
    }

    return Container(
      margin: margin,
      child: content,
    );
  }
}
