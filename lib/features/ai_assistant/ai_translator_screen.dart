import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AiTranslatorScreen extends StatelessWidget {
  const AiTranslatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Live Translator', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.clock, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Language Swap
              GlassContainer.solid(
                padding: const EdgeInsets.symmetric(vertical: 16),
                borderRadius: 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('English (US)', style: AppTextStyles.titleMedium.copyWith(color: AppColors.textSecondary)),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.2), shape: BoxShape.circle),
                      child: const Icon(Iconsax.arrow_swap_horizontal, color: AppColors.primary),
                    ),
                    Text('Japanese', style: AppTextStyles.titleMedium),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              
              // Input Area
              Expanded(
                child: GlassContainer(
                  padding: const EdgeInsets.all(24),
                  borderRadius: 32,
                  child: Column(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          style: AppTextStyles.displaySmall,
                          decoration: InputDecoration(
                            hintText: 'Tap the mic or type to translate...',
                            hintStyle: AppTextStyles.displaySmall.copyWith(color: AppColors.textSecondary.withValues(alpha: 0.5)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Iconsax.copy, color: AppColors.textSecondary),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Iconsax.volume_high, color: AppColors.textSecondary),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              
              // Mic Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.primary, Colors.blueAccent.withValues(alpha: 0.8)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 24,
                        spreadRadius: 8,
                      )
                    ],
                  ),
                  child: const Center(
                    child: Icon(Iconsax.microphone_2, color: Colors.white, size: 40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
