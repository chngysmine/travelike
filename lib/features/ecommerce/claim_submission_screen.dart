import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ClaimSubmissionScreen extends StatelessWidget {
  const ClaimSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('File a Claim', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Active Policy info
            GlassContainer.solid(
              padding: const EdgeInsets.all(16),
              borderRadius: 16,
              color: AppColors.accentTeal.withValues(alpha: 0.1),
              child: Row(
                children: [
                  const Icon(Icons.shield, color: AppColors.accentTeal, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Active Policy: Comprehensive Explorer', style: AppTextStyles.labelMedium),
                        Text('Valid for Vietnam until Oct 25, 2026', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Claim Type', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppColors.cardShadow),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: 'Flight Delay',
                  items: const [
                    DropdownMenuItem(value: 'Flight Delay', child: Text('Flight Delay (Baggage / Time)')),
                    DropdownMenuItem(value: 'Medical', child: Text('Medical Emergency (Hospital)')),
                    DropdownMenuItem(value: 'Accident', child: Text('Motorbike Accident')),
                  ],
                  onChanged: (v) {},
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text('Incident Details', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppColors.cardShadow),
              child: const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'E.g., Flight VN218 from SGN to HAN was delayed by 8 hours due to weather...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text('Attachments (Receipts / Reports)', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(16),
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
              child: Column(
                children: [
                  const Icon(Iconsax.document_upload, color: AppColors.primary, size: 40),
                  const SizedBox(height: 12),
                  Text('Tap to upload documents', style: AppTextStyles.labelMedium),
                ],
              ),
            ),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Submit Claim', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
