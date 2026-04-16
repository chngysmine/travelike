import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class TravelikePremiumScreen extends StatelessWidget {
  const TravelikePremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Travelike Premium', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Branding Header
            Center(
              child: Column(
                children: [
                   const Icon(Icons.diamond_outlined, color: AppColors.accentGold, size: 64),
                   const SizedBox(height: 16),
                   Text('Travelike Black', style: AppTextStyles.displayMedium.copyWith(color: AppColors.accentGold)),
                   const SizedBox(height: 8),
                   Text('Unlock the ultimate Vietnam travel experience.', style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 48),

            Text('Exclusive Benefits', style: AppTextStyles.titleLarge),
            const SizedBox(height: 24),
            _buildBenefit(Icons.cloud_off, 'Unlimited Offline Mode', 'Download entire cities instead of single regions.'),
            _buildBenefit(Icons.support_agent, '24/7 Priority Concierge', 'Connect with local Vietnamese experts instantly.'),
            _buildBenefit(Icons.airplane_ticket, 'No Booking Fees', '0% commission on flights and hotels in Vietnam.'),
            _buildBenefit(Icons.airline_seat_recline_extra, 'Free Lounge Access', '3 free entries per year to Bamboo Airways lounges.'),

            const SizedBox(height: 40),
            
            // Pricing Plan
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Annual Plan', style: AppTextStyles.titleMedium),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                        child: Text('-20%', style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('499,000', style: AppTextStyles.displayMedium),
                      const SizedBox(width: 8),
                      Text('VND / year', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentGold,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Upgrade to Black', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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

  Widget _buildBenefit(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accentGold, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleSmall),
                const SizedBox(height: 4),
                Text(desc, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
