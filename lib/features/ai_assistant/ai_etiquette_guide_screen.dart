import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AiEtiquetteGuideScreen extends StatelessWidget {
  const AiEtiquetteGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('AI Culture Guide', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Current Location/Theme Header
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Target Destination', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
                          const SizedBox(height: 4),
                          Text('Hanoi, Vietnam', style: AppTextStyles.titleLarge),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Iconsax.teacher, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Iconsax.magic_star, color: Colors.amber, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "AI Tip: Always hand over and receive items, especially money, with both hands to show respect.",
                            style: AppTextStyles.bodySmall.copyWith(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Categories
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                children: [
                  _buildCategoryTab('All Rules', true),
                  _buildCategoryTab('Dining', false),
                  _buildCategoryTab('Greetings', false),
                  _buildCategoryTab('Tipping', false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text('Essential Do\'s & Don\'ts', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),

            // Do's List
            _buildRuleCard(
              title: 'Crossing the street smoothly',
              description: 'Walk at a slow, steady pace and let the motorbikes flow around you.',
              isDo: true,
            ),
            _buildRuleCard(
              title: 'Dress modestly at temples',
              description: 'Always cover your shoulders and knees when visiting pagodas.',
              isDo: true,
            ),

            // Don'ts List
            _buildRuleCard(
              title: 'Don\'t leave chopsticks standing up',
              description: 'It resembles incense burned for the dead and is considered bad luck.',
              isDo: false,
            ),
            _buildRuleCard(
              title: 'Don\'t touch someone\'s head',
              description: 'The head is considered the most sacred part of the body in culture.',
              isDo: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent),
      ),
      child: Center(
        child: Text(
          title,
          style: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildRuleCard({required String title, required String description, required bool isDo}) {
    final color = isDo ? Colors.greenAccent : Colors.redAccent;
    final icon = isDo ? Iconsax.tick_circle : Iconsax.close_circle;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(16),
        borderRadius: 16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
