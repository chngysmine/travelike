import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class OfflineModeHubScreen extends StatelessWidget {
  const OfflineModeHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Offline Hub', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            Switch(value: false, onChanged: (v){}, activeTrackColor: AppColors.primary),
            const SizedBox(width: 12),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Status
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 20,
              color: Colors.white.withValues(alpha: 0.05),
              child: Row(
                children: [
                  const Icon(Icons.cloud_done, color: AppColors.primary, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1.2 GB Downloaded', style: AppTextStyles.titleSmall),
                        Text('All essential data for your next trip is ready offline.', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Downloaded Regions', style: AppTextStyles.titleLarge),
            const SizedBox(height: 16),

            _buildDownloadItem('Hanoi Capital', 'Maps, Guides, AI Translation Pack', '450 MB', true),
            _buildDownloadItem('Ha Long Bay', 'Map Routes', '120 MB', true),
            _buildDownloadItem('Ho Chi Minh City', 'Maps, Guides', '600 MB', false),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadItem(String title, String details, String size, bool isDownloaded) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(16),
        borderRadius: 20,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDownloaded ? Colors.green.withValues(alpha: 0.1) : AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(isDownloaded ? Icons.download_done : Icons.download, color: isDownloaded ? Colors.green : AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall),
                  const SizedBox(height: 4),
                  Text(details, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textTertiary)),
                ],
              ),
            ),
            Text(size, style: AppTextStyles.labelMedium),
          ],
        ),
      ),
    );
  }
}
