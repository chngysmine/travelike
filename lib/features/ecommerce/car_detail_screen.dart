import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Car Detail', style: AppTextStyles.titleMedium.copyWith(color: AppColors.textPrimary)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 24,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Icon(Iconsax.magic_star, color: AppColors.primary, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Overview', style: AppTextStyles.titleSmall),
                        Text('Welcome to Car Detail', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Features', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: List.generate(4, (index) => GlassContainer.solid(
                padding: const EdgeInsets.all(16),
                borderRadius: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.folder_open, color: AppColors.textPrimary),
                    const SizedBox(height: 8),
                    Text('Item ${index + 1}', style: AppTextStyles.labelMedium),
                  ],
                ),
              )),
            ),
            const SizedBox(height: 24),
            Text('Recent Data', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            ...List.generate(5, (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassContainer.solid(
                padding: const EdgeInsets.all(16),
                borderRadius: 16,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Iconsax.activity, size: 16)
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Text('Data Entry ${index + 1}', style: AppTextStyles.labelMedium)),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textTertiary),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
