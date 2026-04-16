import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GlobalLeaderboardScreen extends StatelessWidget {
  const GlobalLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Vietnam Explorers', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.info_circle, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            // Top 3 Podium
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildPodiumUser(2, 'Linh', '12.4k', 120, 'https://i.pravatar.cc/150?u=2', Colors.blueGrey),
                _buildPodiumUser(1, 'Khoa', '15.8k', 160, 'https://i.pravatar.cc/150?u=1', AppColors.accentGold),
                _buildPodiumUser(3, 'Mai', '10.2k', 100, 'https://i.pravatar.cc/150?u=3', Colors.orangeAccent),
              ],
            ),
            const SizedBox(height: 30),
            
            // Your Rank Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GlassContainer.solid(
                padding: const EdgeInsets.all(16),
                borderRadius: 20,
                color: AppColors.primary.withValues(alpha: 0.1),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: Text('#45', style: AppTextStyles.titleMedium.copyWith(color: Colors.white)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('You (Huy)', style: AppTextStyles.titleSmall),
                          Text('4,500 XP - 150 to next rank', style: AppTextStyles.labelSmall),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_upward_rounded, color: Colors.green),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: _buildTab('Global', true)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildTab('Friends', false)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildTab('Ha Giang Loop', false)), // Localized challenge
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Ranking List
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildRankItem(index + 4);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumUser(int rank, String name, String points, double height, String imageUrl, Color color) {
    return Column(
      children: [
        if (rank == 1) const Icon(Icons.star, color: AppColors.accentGold, size: 32),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 3),
            image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: AppTextStyles.labelMedium),
        Text(points, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          child: Center(
            child: Text('$rank', style: AppTextStyles.displaySmall.copyWith(color: color)),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: AppTextStyles.labelMedium.copyWith(color: isSelected ? Colors.white : AppColors.textPrimary),
      ),
    );
  }

  Widget _buildRankItem(int rank) {
    final names = ['Tuan Anh', 'Minh Tri', 'Huong Giang', 'Chi Pu', 'Son Tung', 'Bao Tram'];
    final points = ['9.8k', '8.5k', '8.2k', '7.9k', '7.5k', '7.1k'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer.solid(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 16,
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Text('#$rank', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=$rank'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(names[rank - 4], style: AppTextStyles.titleSmall),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(points[rank - 4], style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
            ),
          ],
        ),
      ),
    );
  }
}
