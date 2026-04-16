import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class TravelInsuranceScreen extends StatelessWidget {
  const TravelInsuranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Travel Insurance', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Hero
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              child: Row(
                children: [
                  const Icon(Icons.health_and_safety, color: Colors.greenAccent, size: 48),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Protect Your Vietnam Trip', style: AppTextStyles.titleMedium),
                        const SizedBox(height: 4),
                        Text('Medical, scooter accidents, and flight delays covered.', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Select a Plan', style: AppTextStyles.titleLarge),
            Text('Prices based on a 7-day trip', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 16),

            // Premium Plan
            _buildPlanCard(
              title: 'Comprehensive Explorer',
              price: '450,000 VND',
              isPopular: true,
              features: [
                'Up to 2B VND Medical Coverage',
                'Motorbike Accident Cover (Must have valid license)',
                'Flight Cancellation & Delay',
                'Lost Baggage (20M VND)',
              ],
              color: AppColors.primary,
            ),

            // Basic Plan
            _buildPlanCard(
              title: 'Basic Protect',
              price: '150,000 VND',
              isPopular: false,
              features: [
                'Up to 500M VND Medical Coverage',
                'Flight Delay (Over 6 hours)',
                'No Motorbike Cover',
              ],
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required bool isPopular,
    required List<String> features,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: isPopular ? AppColors.accentGold : Colors.white12, width: isPopular ? 2 : 1),
              color: Colors.white.withValues(alpha: 0.05),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleLarge.copyWith(color: color)),
                const SizedBox(height: 8),
                Text(price, style: AppTextStyles.displayMedium),
                const SizedBox(height: 24),
                ...features.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20),
                      const SizedBox(width: 12),
                      Expanded(child: Text(e, style: AppTextStyles.labelMedium)),
                    ],
                  ),
                )),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPopular ? AppColors.primary : Colors.white12,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text('Select Plan', style: TextStyle(color: isPopular ? Colors.white : AppColors.textPrimary)),
                  ),
                ),
              ],
            ),
          ),
          if (isPopular)
            Positioned(
              top: -12,
              right: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentGold,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2))],
                ),
                child: const Text('MOST POPULAR', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
    );
  }
}
