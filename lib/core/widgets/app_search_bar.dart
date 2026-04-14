import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

/// Standardized search bar widget replacing 5+ duplicate implementations.
class AppSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onChanged;
  final bool showMicrophone;
  final bool showFilter;
  final bool isInteractive;
  final TextEditingController? controller;

  const AppSearchBar({
    super.key,
    this.hintText = 'Search...',
    this.onTap,
    this.onFilterTap,
    this.onChanged,
    this.showMicrophone = false,
    this.showFilter = false,
    this.isInteractive = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isInteractive ? null : onTap,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppSpacing.borderLg,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Icon(
              Iconsax.search_normal,
              size: 20,
              color: AppColors.textTertiary.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: isInteractive
                  ? TextField(
                      controller: controller,
                      onChanged: onChanged,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: AppTextStyles.bodyMedium.tertiary,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    )
                  : Text(
                      hintText,
                      style: AppTextStyles.bodyMedium.tertiary,
                    ),
            ),
            if (showMicrophone) ...[
              const SizedBox(width: 8),
              Icon(Iconsax.microphone_2, size: 20, color: AppColors.textTertiary.withValues(alpha: 0.6)),
            ],
            if (showFilter) ...[
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onFilterTap,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: AppSpacing.borderSm,
                  ),
                  child: const Icon(Iconsax.setting_4, size: 16, color: AppColors.primary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
