import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class ScamRadarScreen extends StatelessWidget {
  const ScamRadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Tourist Scam Radar', style: AppTextStyles.titleMedium),
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
              borderRadius: 20,
              color: Colors.redAccent.withValues(alpha: 0.1),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('High Alert Zone: Ben Thanh Market', style: AppTextStyles.labelMedium.copyWith(color: Colors.redAccent)),
                        const SizedBox(height: 4),
                        Text('Multiple reports of overcharging today. Always bargain to at least 50% off the initial price.', style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Reports near you', style: AppTextStyles.titleLarge),
                const Icon(Icons.add_alert, color: AppColors.primary),
              ],
            ),
            const SizedBox(height: 16),

            _buildScamReport(
              type: 'Taxi Overcharging',
              location: 'Tan Son Nhat Airport Arrivals',
              description: 'Driver refused to turn on the meter and asked for 500k VND to District 1. Use Grab instead.',
              time: '2 hours ago',
              upvotes: 45,
            ),
            _buildScamReport(
              type: 'Fake Coconut Sellers',
              location: 'Hoan Kiem Lake, Hanoi',
              description: 'Venders will put their carrying pole on your shoulder for a photo and then demand 200k VND. Say no firmly.',
              time: '5 hours ago',
              upvotes: 120,
            ),
            _buildScamReport(
              type: 'Pickpocket Warning',
              location: 'Bui Vien Walking Street',
              description: 'Keep your phones secure. Two men on a motorbike snatched a phone from someone taking a selfie.',
              time: '1 day ago',
              upvotes: 210,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScamReport({
    required String type,
    required String location,
    required String description,
    required String time,
    required int upvotes,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(20),
        borderRadius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.redAccent.withValues(alpha: 0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.campaign, color: Colors.redAccent, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(type, style: AppTextStyles.titleSmall),
                      Text(location, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Text(time, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textTertiary)),
              ],
            ),
            const SizedBox(height: 16),
            Text(description, style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70)),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.thumb_up_alt_outlined, color: AppColors.textSecondary, size: 16),
                const SizedBox(width: 8),
                Text('$upvotes Helpful', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
