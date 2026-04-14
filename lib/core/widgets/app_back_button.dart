import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Standardized back button replacing 15+ different inline implementations.
/// Provides consistent sizing, styling, and hit area across all screens.
class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool isOnImage;
  final double size;

  const AppBackButton({
    super.key,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.isOnImage = false,
    this.size = 40,
  });

  /// For use on top of images/dark backgrounds
  factory AppBackButton.onImage({Key? key, VoidCallback? onTap}) {
    return AppBackButton(
      key: key,
      onTap: onTap,
      isOnImage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.maybePop(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ??
              (isOnImage
                  ? Colors.white.withValues(alpha: 0.9)
                  : Colors.white),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isOnImage
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 16,
          color: iconColor ?? AppColors.textPrimary,
        ),
      ),
    );
  }
}

/// Standardized action button (bookmark, share, etc.) for app bars
class AppActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool isOnImage;
  final double size;
  final double iconSize;

  const AppActionButton({
    super.key,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.backgroundColor,
    this.isOnImage = false,
    this.size = 40,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor ??
              (isOnImage
                  ? Colors.white.withValues(alpha: 0.9)
                  : Colors.white),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isOnImage
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? AppColors.textPrimary,
        ),
      ),
    );
  }
}
