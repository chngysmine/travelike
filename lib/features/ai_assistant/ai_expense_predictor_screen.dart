import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AiExpensePredictorScreen extends StatelessWidget {
  const AiExpensePredictorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('AI Expense Predictor', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.more, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Gauge / Total Card
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              child: Column(
                children: [
                  Text('Predicted Trip Cost', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 8),
                  Text('\$1,850.00', style: AppTextStyles.displaySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Iconsax.trend_down, color: Colors.greenAccent, size: 16),
                        const SizedBox(width: 6),
                        Text('12% cheaper than average', style: AppTextStyles.labelSmall.copyWith(color: Colors.greenAccent)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Mockup Bar Chart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildChartBar('Food', 0.4, Colors.orangeAccent),
                      _buildChartBar('Stay', 0.8, Colors.blueAccent),
                      _buildChartBar('Travel', 0.6, Colors.purpleAccent),
                      _buildChartBar('Fun', 0.3, Colors.pinkAccent),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cost Breakdown', style: AppTextStyles.titleSmall),
                Text('Modify Plan', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 16),

            // Breakdowns
            _buildExpenseCategory(
              icon: Iconsax.building_3,
              iconColor: Colors.blueAccent,
              title: 'Accommodation',
              subtitle: '7 nights at 4-star hotels',
              amount: '\$850',
              progress: 0.6,
            ),
            _buildExpenseCategory(
              icon: Iconsax.airplane,
              iconColor: Colors.purpleAccent,
              title: 'Flights & Transit',
              subtitle: 'Round-trip + local passes',
              amount: '\$520',
              progress: 0.4,
            ),
            _buildExpenseCategory(
              icon: Iconsax.coffee,
              iconColor: Colors.orangeAccent,
              title: 'Food & Dining',
              subtitle: 'Estimated 3 meals/day',
              amount: '\$320',
              progress: 0.3,
            ),
            _buildExpenseCategory(
              icon: Iconsax.ticket,
              iconColor: Colors.pinkAccent,
              title: 'Entertainment',
              subtitle: 'Museums & excursions',
              amount: '\$160',
              progress: 0.15,
            ),
            
            const SizedBox(height: 24),
            // AI Suggestion Banner
            GlassContainer.solid(
              padding: const EdgeInsets.all(16),
              borderRadius: 16,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Icon(Iconsax.lamp_on, color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AI Optimization', style: AppTextStyles.titleSmall),
                        const SizedBox(height: 4),
                        Text('Switching to a weekend flex pass could save you \$45.', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartBar(String label, double heightFraction, Color color) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 80 * heightFraction,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildExpenseCategory({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String amount,
    required double progress,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(16),
        borderRadius: 16,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.titleSmall),
                      Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Text(amount, style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
                valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
