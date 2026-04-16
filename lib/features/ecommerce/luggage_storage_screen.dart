import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class LuggageStorageScreen extends StatelessWidget {
  const LuggageStorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Luggage Lockers', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Map Mockup
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network('https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', fit: BoxFit.cover),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.5), blurRadius: 10)]),
                        child: const Icon(Icons.luggage, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Station Details
            Text('Da Nang Railway Station Lockers', style: AppTextStyles.titleLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text('202 Hai Phong, Da Nang', style: AppTextStyles.bodyMedium),
              ],
            ),
            const SizedBox(height: 32),

            Text('Select Locker Size', style: AppTextStyles.titleMedium),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(child: _buildSizeCard('Medium', 'Fits 1 Cabin Bag', '50,000 VND', true)),
                const SizedBox(width: 16),
                Expanded(child: _buildSizeCard('Large', 'Fits 2 Large Bags', '100,000 VND', false)),
              ],
            ),
            const SizedBox(height: 32),

            // Time Selector
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Duration', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimeChip('4 Hours', false),
                      _buildTimeChip('Full Day (24h)', true),
                      _buildTimeChip('2 Days', false),
                    ],
                  ),
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
              child: const Text('Book Locker for 50,000 VND', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeCard(String title, String subtitle, String price, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.5),
        border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.backpack, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 32),
          const SizedBox(height: 12),
          Text(title, style: AppTextStyles.titleSmall),
          const SizedBox(height: 4),
          Text(subtitle, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, fontSize: 10)),
          const SizedBox(height: 12),
          Text(price, style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildTimeChip(String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(title, style: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary, fontSize: 12)),
    );
  }
}
