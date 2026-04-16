import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CreatorDashboardScreen extends StatelessWidget {
  const CreatorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Creator Studio', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.chart, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Revenue Card
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              color: AppColors.primaryDark,
              child: Column(
                children: [
                  Text('Estimated Revenue (7 Days)', style: AppTextStyles.labelMedium.copyWith(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text('15,200,000 VND', style: AppTextStyles.displayMedium.copyWith(color: Colors.white)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Icon(Icons.show_chart, color: Colors.greenAccent),
                            const SizedBox(height: 8),
                            Text('+12% views', style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 40, color: Colors.white24),
                      Expanded(
                        child: Column(
                          children: [
                            const Icon(Icons.groups, color: AppColors.accentGold),
                            const SizedBox(height: 8),
                            Text('+450 Subs', style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Text('Top Performing Guides in Vietnam', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            
            // Reel/Post Stats
            _buildContentStatItem(
              title: 'Ultimate 48h in Ho Chi Minh',
              type: 'Reel',
              views: '124K',
              earnings: '4.2M VND',
              imageUrl: 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
            ),
            _buildContentStatItem(
              title: 'Sapa Trekking Hidden Trails',
              type: 'Blog Guide',
              views: '89K',
              earnings: '3.1M VND',
              imageUrl: 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800',
            ),
            _buildContentStatItem(
              title: 'Best Banh Mi spots',
              type: 'Reel',
              views: '210K',
              earnings: '7.9M VND',
              imageUrl: 'https://images.unsplash.com/photo-1533050487297-09b450131914?w=800',
            ),

            const SizedBox(height: 30),
            Text('Monetization Tools', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildToolBtn(Iconsax.ticket_star, 'Sponsorships', Colors.amber)),
                const SizedBox(width: 12),
                Expanded(child: _buildToolBtn(Iconsax.shop, 'Merch Store', Colors.purpleAccent)),
                const SizedBox(width: 12),
                Expanded(child: _buildToolBtn(Iconsax.bank, 'Payouts', Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentStatItem({
    required String title,
    required String type,
    required String views,
    required String earnings,
    required String imageUrl,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(12),
        borderRadius: 16,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall, maxLines: 1),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
                        child: Text(type, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                      ),
                      const SizedBox(width: 8),
                      Text('$views Views', style: AppTextStyles.labelSmall),
                    ],
                  ),
                ],
              ),
            ),
            Text(earnings, style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
          ],
        ),
      ),
    );
  }

  Widget _buildToolBtn(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.labelSmall),
        ],
      ),
    );
  }
}
