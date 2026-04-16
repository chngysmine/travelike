import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HealthPassportScreen extends StatelessWidget {
  const HealthPassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Health Passport', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(icon: const Icon(Iconsax.document_download, color: AppColors.primary), onPressed: () {}),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Status Card
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              child: Column(
                children: [
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.verified, color: Colors.greenAccent, size: 48),
                  ),
                  const SizedBox(height: 16),
                  Text('Cleared for Travel', style: AppTextStyles.titleLarge),
                  Text('Vietnam Entry Requirements Met', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.network('https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=TravelikePassport', height: 120, width: 120),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Vaccination Records', style: AppTextStyles.titleMedium),
            const SizedBox(height: 16),
            
            _buildRecordRow('COVID-19', '3 Doses (Pfizer)', 'Valid', Colors.green),
            _buildRecordRow('Yellow Fever', 'Not Required for VN', 'Exempt', Colors.grey),
            _buildRecordRow('Typhoid', '1 Dose', 'Recommended', Colors.orange),

            const SizedBox(height: 32),
            Text('Nearby Clinics (English Speaking)', style: AppTextStyles.titleMedium),
            const SizedBox(height: 16),
            GlassContainer.solid(
              padding: const EdgeInsets.all(16),
              borderRadius: 20,
              child: Row(
                children: [
                  const Icon(Icons.local_hospital, color: Colors.redAccent, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text('FV Hospital HCMC', style: AppTextStyles.titleSmall),
                         Text('6 Nguyen Luong Bang St, D7', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  const Icon(Icons.call, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordRow(String name, String details, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer.dark(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        borderRadius: 16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.labelMedium),
                Text(details, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
              child: Text(status, style: AppTextStyles.labelSmall.copyWith(color: statusColor)),
            ),
          ],
        ),
      ),
    );
  }
}
