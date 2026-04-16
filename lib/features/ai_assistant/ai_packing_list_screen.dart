import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AiPackingListScreen extends StatelessWidget {
  const AiPackingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              backgroundColor: Colors.transparent,
              elevation: 0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                title: Text('Smart Packing', style: AppTextStyles.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black54, Colors.transparent, Colors.black87],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Iconsax.add, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
            // Climate Context Card
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 24,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.blue, Colors.cyan]),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Iconsax.cloud_snow, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sapa, Vietnam', style: AppTextStyles.titleSmall),
                        Text('-2°C to 5°C • Snowy', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                        const SizedBox(height: 4),
                        Text('AI Suggests: Heavy Winter Layers', style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('6/15 Packed', style: AppTextStyles.titleSmall),
                Text('40%', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 0.4,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 32),

            // Category: Clothing
            _buildCategoryHeader('Clothing (Winter)', Iconsax.mask),
            _buildChecklistItem(name: 'Thermal Innerwear (x4)', isChecked: true),
            _buildChecklistItem(name: 'Heavy Down Jacket', isChecked: true),
            _buildChecklistItem(name: 'Woolen Sweaters (x3)', isChecked: false),
            _buildChecklistItem(name: 'Waterproof Boots', isChecked: false),
            _buildChecklistItem(name: 'Gloves & Beanie', isChecked: false),
            
            const SizedBox(height: 24),
            
            // Category: Gadgets
            _buildCategoryHeader('Gadgets', Iconsax.mobile),
            _buildChecklistItem(name: 'Power Bank (10,000mAh)', isChecked: true),
            _buildChecklistItem(name: 'Universal Adapter', isChecked: true),
            _buildChecklistItem(name: 'Camera & Lenses', isChecked: false, isAIRecommended: true),
            
            const SizedBox(height: 24),

            // Category: Documents
            _buildCategoryHeader('Documents', Iconsax.document),
            _buildChecklistItem(name: 'Passport & Visa', isChecked: true),
            _buildChecklistItem(name: 'Travel Insurance Printout', isChecked: false),
            
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Text(title, style: AppTextStyles.titleMedium),
        ],
      ),
    );
  }

  Widget _buildChecklistItem({required String name, required bool isChecked, bool isAIRecommended = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer.solid(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 16,
        child: Row(
          children: [
            Icon(
              isChecked ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              color: isChecked ? Colors.greenAccent : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: AppTextStyles.bodyMedium.copyWith(
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                  color: isChecked ? AppColors.textSecondary : AppColors.textPrimary,
                ),
              ),
            ),
            if (isAIRecommended)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.purple, Colors.pink]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Iconsax.magic_star, color: Colors.white, size: 10),
                    const SizedBox(width: 4),
                    Text('AI Pick', style: AppTextStyles.labelSmall.copyWith(fontSize: 10)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
