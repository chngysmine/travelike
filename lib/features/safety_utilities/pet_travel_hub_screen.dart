import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class PetTravelHubScreen extends StatelessWidget {
  const PetTravelHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Pet Travel Hub', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Primary Pet Info
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 24,
              color: Colors.brown.withValues(alpha: 0.1),
              child: Row(
                children: [
                  Container(
                    width: 70, height: 70,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white)),
                    child: const ClipOval(
                      child: Image(image: NetworkImage('https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800'), fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Milo (Golden Retriever)', style: AppTextStyles.titleSmall),
                        Text('Rabies Vax: Valid until Nov 2026', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                          child: const Text('Fit to fly - Vietnam Airlines', style: TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Pet-Friendly Vietnam', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            
            _buildPetFriendlyItem(
              'Villa Da Lat',
              'Hotel • Pets allowed Free',
              'Da Lat, Vietnam',
              Icons.hotel,
            ),
            _buildPetFriendlyItem(
              'Cong Ca Phe - Hoan Kiem',
              'Cafe • Outdoor seating allowed',
              'Hanoi, Vietnam',
              Icons.local_cafe,
            ),
            _buildPetFriendlyItem(
              'Saigon Pet Clinic',
              'Vet Info • 24/7 ER',
              'District 2, Ho Chi Minh',
              Icons.pets,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetFriendlyItem(String title, String type, String loc, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.dark(
        padding: const EdgeInsets.all(16),
        borderRadius: 20,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.2), shape: BoxShape.circle),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.labelMedium),
                  Text(type, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 12, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Text(loc, style: AppTextStyles.bodySmall),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
