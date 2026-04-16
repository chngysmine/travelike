import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class LoungeBookingScreen extends StatelessWidget {
  const LoungeBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Airport Lounges', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            _buildLoungeCard(
              'Lotus Lounge (Vietnam Airlines)',
              'Noi Bai International (HAN) • Terminal 2',
              'Free Buffet, Showers, Massage Chairs',
              '650,000 VND',
              'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
            ),
            _buildLoungeCard(
              'Le Saigonnais Business Lounge',
              'Tan Son Nhat (SGN) • Domestic Terminal',
              'Pho Station, Craft Beer, Quiet Zones',
              '450,000 VND',
              'https://images.unsplash.com/photo-1528127269322-539801943592?w=800',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoungeCard(String title, String location, String perks, String price, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(0),
        borderRadius: 24,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.network(imageUrl, height: 180, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleLarge),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Expanded(child: Text(location, style: AppTextStyles.labelMedium)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text('Includes: $perks', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price, style: AppTextStyles.displayMedium),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentGold,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('Book Entry', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
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
