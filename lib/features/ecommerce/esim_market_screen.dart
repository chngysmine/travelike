import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class EsimMarketScreen extends StatelessWidget {
  const EsimMarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Vietnam eSIMs', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // How it works banner
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 20,
              color: AppColors.primary.withValues(alpha: 0.1),
              child: Row(
                children: [
                  const Icon(Icons.qr_code_scanner, color: AppColors.primary, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Instant QR Installation', style: AppTextStyles.titleSmall),
                        Text('Scan the QR code after purchase to activate 4G/5G data instantly.', style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Viettel Network (Best Coverage)', style: AppTextStyles.titleMedium),
            const SizedBox(height: 16),
            _buildDataPlanCard('Unlimited Data - 7 Days', 'Viettel', '4G/LTE', '180,000 VND'),
            _buildDataPlanCard('Unlimited Data - 15 Days', 'Viettel', '5G Supported', '250,000 VND'),

            const SizedBox(height: 24),
            Text('Mobifone/Vinaphone', style: AppTextStyles.titleMedium),
            const SizedBox(height: 16),
            _buildDataPlanCard('3GB/Day - 10 Days', 'Vinaphone', '4G/LTE', '120,000 VND'),
          ],
        ),
      ),
    );
  }

  Widget _buildDataPlanCard(String title, String network, String speed, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(20),
        borderRadius: 20,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white24)),
              child: const Icon(Icons.sim_card, color: AppColors.textPrimary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall),
                  const SizedBox(height: 4),
                  Text('$network • $speed', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price, style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
                  child: const Text('Buy', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
