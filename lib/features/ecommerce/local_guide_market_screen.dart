import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class LocalGuideMarketScreen extends StatelessWidget {
  const LocalGuideMarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Hire a Local Guide', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppColors.cardShadow,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Where are you going? (e.g., Hue)',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Guide Specialities
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildTag('Photography', true),
                  _buildTag('History', false),
                  _buildTag('Foodie', false),
                  _buildTag('Nightlife', false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Guide Lists
            _buildGuideCard(
              name: 'Minh Tu',
              specialty: 'Hue Imperial Photographer',
              rating: '4.9',
              reviews: '124',
              price: '500,000 VND',
              imageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026024d',
              languages: 'Eng, VIE',
            ),
            _buildGuideCard(
              name: 'Lan Anh',
              specialty: 'Hoi An Street Food Expert',
              rating: '5.0',
              reviews: '89',
              price: '300,000 VND',
              imageUrl: 'https://i.pravatar.cc/150?img=47',
              languages: 'Eng, KOR',
            ),
            _buildGuideCard(
              name: 'Duc Huy',
              specialty: 'Ha Giang Motorbike Pilot',
              rating: '4.8',
              reviews: '210',
              price: '700,000 VND',
              imageUrl: 'https://i.pravatar.cc/150?img=11',
              languages: 'Eng',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(title, style: AppTextStyles.labelSmall.copyWith(color: isSelected ? Colors.white : AppColors.textPrimary)),
    );
  }

  Widget _buildGuideCard({
    required String name,
    required String specialty,
    required String rating,
    required String reviews,
    required String price,
    required String imageUrl,
    required String languages,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(16),
        borderRadius: 20,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(imageUrl, width: 80, height: 100, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name, style: AppTextStyles.titleMedium),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text(rating, style: AppTextStyles.labelSmall),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(specialty, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  Text('Speaks: $languages', style: AppTextStyles.bodySmall),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$price/hr', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
                        child: const Text('Book', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
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
