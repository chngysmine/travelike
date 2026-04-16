import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AiTripGeneratorScreen extends StatelessWidget {
  const AiTripGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Trip Architect', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Magic Intro
            Row(
              children: [
                const Icon(Iconsax.magic_star, color: Colors.amber, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Let AI craft the perfect itinerary tailored exclusively for you.',
                    style: AppTextStyles.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Where?
            Text('Where to?', style: AppTextStyles.titleSmall),
            const SizedBox(height: 12),
            GlassContainer.solid(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              borderRadius: 16,
              child: Row(
                children: [
                  const Icon(Iconsax.global, color: AppColors.textSecondary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      style: AppTextStyles.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'e.g. Europe, Tokyo, or Safari',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Vibes
            Text('What\'s the vibe?', style: AppTextStyles.titleSmall),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildChip('Relaxing 🌴', true),
                _buildChip('Adventure 🏕️', false),
                _buildChip('Culture 🏯', true),
                _buildChip('Nightlife 🪩', false),
                _buildChip('Foodie 🍜', true),
              ],
            ),
            const SizedBox(height: 24),

            // Who
            Text('Who\'s going?', style: AppTextStyles.titleSmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildSelectionCard(Iconsax.user, 'Solo', false)),
                const SizedBox(width: 12),
                Expanded(child: _buildSelectionCard(Iconsax.heart, 'Couple', true)),
                const SizedBox(width: 12),
                Expanded(child: _buildSelectionCard(Iconsax.profile_2user, 'Family', false)),
              ],
            ),
            const SizedBox(height: 40),

            // Generate Button
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.primary, AppColors.accentTeal]),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 8)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.status_up, color: Colors.white),
                    const SizedBox(width: 8),
                    Text('Generate My Trip', style: AppTextStyles.titleMedium.copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(color: isSelected ? AppColors.primary : AppColors.textPrimary),
      ),
    );
  }

  Widget _buildSelectionCard(IconData icon, String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.withValues(alpha: 0.1)),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 28),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.labelMedium.copyWith(color: isSelected ? AppColors.primary : AppColors.textSecondary)),
        ],
      ),
    );
  }
}
