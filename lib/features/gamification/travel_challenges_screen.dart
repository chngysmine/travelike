import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class TravelChallengesScreen extends StatelessWidget {
  const TravelChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Vietnam Challenges', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Hero VIP Challenge
            GlassContainer.solid(
              padding: const EdgeInsets.all(0),
              borderRadius: 24,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    Image.network('https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', height: 200, width: double.infinity, fit: BoxFit.cover),
                    Positioned.fill(
                      child: Container(color: Colors.black.withValues(alpha: 0.4)),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(color: AppColors.accentGold, borderRadius: BorderRadius.circular(8)),
                            child: const Text('LEGENDARY TIER', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)),
                          ),
                          const SizedBox(height: 8),
                          Text('Son Doong Cave Expedition', style: AppTextStyles.displaySmall.copyWith(color: Colors.white)),
                          const SizedBox(height: 4),
                          Text('Reward: 10,000 XP & Golden Badge', style: AppTextStyles.labelMedium.copyWith(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            Text('Active Weekly Challenges', style: AppTextStyles.titleMedium),
            const SizedBox(height: 16),
            
            _buildChallengeCard(
              title: 'Street Food Master',
              desc: 'Try 5 different street foods in Hanoi Old Quarter.',
              progress: 3,
              total: 5,
              reward: '500 XP',
            ),
            _buildChallengeCard(
              title: 'Cafe Hopper: Da Lat',
              desc: 'Visit and review 3 acoustic cafes in Da Lat.',
              progress: 1,
              total: 3,
              reward: '300 XP',
            ),
            _buildChallengeCard(
              title: 'Hai Van Pass Rider',
              desc: 'Ride exactly 21km through the beautiful pass.',
              progress: 0,
              total: 21,
              reward: 'Unlock Special Frame',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String desc,
    required int progress,
    required int total,
    required String reward,
  }) {
    double percent = progress / total;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(20),
        borderRadius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(title, style: AppTextStyles.titleSmall)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(reward, style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(desc, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: percent,
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                    color: AppColors.primary,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Text('$progress / $total', style: AppTextStyles.labelMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
