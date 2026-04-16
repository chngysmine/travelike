import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TravelPassportScreen extends StatelessWidget {
  const TravelPassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Virtual Passport', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Passport Cover Simulation Card
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              color: AppColors.primaryDark,
              child: Column(
                children: [
                  const Icon(Icons.public, color: AppColors.accentGold, size: 64),
                  const SizedBox(height: 16),
                  Text('TRAVELIKE PASSPORT', style: AppTextStyles.brand.copyWith(letterSpacing: 4, fontSize: 16, color: AppColors.accentGold)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Huy Nguyen', style: AppTextStyles.titleLarge.copyWith(color: Colors.white)),
                            const SizedBox(height: 4),
                            Text('Level 8 Explorer', style: AppTextStyles.labelMedium.copyWith(color: AppColors.accentGold)),
                            Text('VN-2026-98X', style: AppTextStyles.labelSmall.copyWith(color: Colors.white54)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: AppColors.accentGold.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.accentGold)),
                        child: Text('PRO', style: AppTextStyles.labelSmall.copyWith(color: AppColors.accentGold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Collected Stamps', style: AppTextStyles.titleLarge),
                Text('12/63 Provinces', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 20),

            // Stamps Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
              children: [
                _buildStampCard('Ha Long Bay', 'Oct 2025', 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', true),
                _buildStampCard('Hoi An Ancient', 'Jan 2026', 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800', true),
                _buildStampCard('Phong Nha', 'Mar 2026', 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', true),
                _buildStampCard('Sapa Fansipan', 'Not visited', 'https://images.unsplash.com/photo-1553531384-cc64ac80f931?w=800', false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStampCard(String title, String date, String coverUrl, bool isCollected) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ColorFiltered(
                    colorFilter: isCollected ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply) : const ColorFilter.mode(Colors.grey, BlendMode.saturation),
                    child: Image.network(coverUrl, fit: BoxFit.cover),
                  ),
                  if (isCollected)
                    Center(
                      child: Transform.rotate(
                        angle: -0.1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.redAccent, width: 3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('OFFICIAL', style: AppTextStyles.brand.copyWith(color: Colors.redAccent, fontSize: 14)),
                        ),
                      ),
                    ),
                  if (!isCollected)
                    Container(color: Colors.black.withValues(alpha: 0.3)),
                  if (!isCollected)
                    const Center(child: Icon(Iconsax.lock, color: Colors.white, size: 32)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(date, style: AppTextStyles.labelSmall.copyWith(color: isCollected ? AppColors.primary : AppColors.textTertiary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
