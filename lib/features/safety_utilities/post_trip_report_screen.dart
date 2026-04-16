import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class PostTripReportScreen extends StatelessWidget {
  const PostTripReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Trip Report', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Title
            Center(
              child: Column(
                children: [
                  Text('Hoi An & Da Nang', style: AppTextStyles.titleLarge),
                  Text('Oct 10 - Oct 15 • 5 Days', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Metrics
            Row(
              children: [
                Expanded(child: _buildMetricCard('Total Spent', '8.5M VND', Icons.wallet, AppColors.primary)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Distance', '142 km', Icons.directions_walk, Colors.greenAccent)),
              ],
            ),
            const SizedBox(height: 32),

            Text('Cost Breakdown', style: AppTextStyles.titleMedium),
            const SizedBox(height: 16),
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 20,
              child: Column(
                children: [
                  _buildCostRow('Accommodations', '3.5M VND', 0.4),
                  _buildCostRow('Food & Drinks', '2.8M VND', 0.3),
                  _buildCostRow('Transport', '1.2M VND', 0.15),
                  _buildCostRow('Activities/Tickets', '1.0M VND', 0.1),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('AI Insights', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            GlassContainer.dark(
              padding: const EdgeInsets.all(20),
              borderRadius: 20,
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: AppColors.accentGold),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text('You spent 15% less on food than the average traveler in Da Nang! Great job finding local eateries.', style: AppTextStyles.bodySmall),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color) {
    return GlassContainer.solid(
      padding: const EdgeInsets.all(16),
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(value, style: AppTextStyles.titleSmall),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildCostRow(String category, String amount, double ratio) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category, style: AppTextStyles.bodyMedium),
              Text(amount, style: AppTextStyles.labelMedium),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: ratio,
            backgroundColor: Colors.white12,
            color: AppColors.primary,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
