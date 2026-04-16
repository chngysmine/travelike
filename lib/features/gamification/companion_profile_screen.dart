import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CompanionProfileScreen extends StatelessWidget {
  const CompanionProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: AppColors.backgroundDark,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, AppColors.backgroundDark],
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
              IconButton(icon: const Icon(Iconsax.message, color: Colors.white), onPressed: () {}),
            ],
          ),
          
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.backgroundDark,
              child: GradientBackground(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Header Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Hoang Linh, 24', style: AppTextStyles.displayMedium.copyWith(color: Colors.white)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, color: AppColors.primary, size: 16),
                                  const SizedBox(width: 4),
                                  Text('Based in Ho Chi Minh City', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
                            child: const Text('Add Friend', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Stats
                      Row(
                        children: [
                          Expanded(child: _buildStatItem('34', 'Provinces')),
                          Expanded(child: _buildStatItem('12', 'Trips Together')),
                          Expanded(child: _buildStatItem('8.4k', 'Followers')),
                        ],
                      ),
                      const SizedBox(height: 32),

                      Text('Travel Badges', style: AppTextStyles.titleMedium),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            _buildBadgeCard('Phở Connoisseur', Icons.soup_kitchen, Colors.orange),
                            _buildBadgeCard('Ha Giang Survivor', Icons.pedal_bike, Colors.blueAccent),
                            _buildBadgeCard('Cave Explorer', Icons.dark_mode, Colors.purpleAccent),
                            _buildBadgeCard('Beach Bum', Icons.beach_access, Colors.yellow),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      Text('Upcoming Public Trips', style: AppTextStyles.titleMedium),
                      const SizedBox(height: 16),
                      GlassContainer.dark(
                        padding: const EdgeInsets.all(16),
                        borderRadius: 20,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network('https://images.unsplash.com/photo-1528127269322-539801943592?w=800', width: 60, height: 60, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hanoi Train Street Coffee', style: AppTextStyles.titleSmall.copyWith(color: Colors.white)),
                                  Text('Nov 15 - Looking for 1 buddy', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios, color: AppColors.textTertiary, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.displayMedium.copyWith(color: Colors.white)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildBadgeCard(String label, IconData icon, Color color) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
