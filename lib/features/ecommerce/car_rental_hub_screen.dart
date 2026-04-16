import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CarRentalHubScreen extends StatelessWidget {
  const CarRentalHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Rentals in Da Nang', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(icon: const Icon(Iconsax.filter, color: AppColors.textPrimary), onPressed: () {}),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Search / Date Picker
            GlassContainer.dark(
              padding: const EdgeInsets.all(16),
              borderRadius: 20,
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pick-up', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        Text('Oct 15, 10:00 AM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 40, color: Colors.white24),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Drop-off', style: TextStyle(color: Colors.white54, fontSize: 12)),
                          Text('Oct 18, 10:00 AM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildCategoryChip('Motorbikes', true),
                  _buildCategoryChip('Electric Cars', false),
                  _buildCategoryChip('SUVs', false),
                  _buildCategoryChip('Vans', false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Car Listings
            _buildVehicleCard('Honda Air Blade 125cc', 'Scooter • Auto', '150,000', 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800'),
            _buildVehicleCard('VinFast Feliz S', 'Electric • Auto', '200,000', 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800'),
            _buildVehicleCard('VinFast VF8', 'Electric SUV • 5 Seats', '1,200,000', 'https://images.unsplash.com/photo-1533050487297-09b450131914?w=800'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(title, style: AppTextStyles.labelMedium.copyWith(color: isSelected ? Colors.white : AppColors.textPrimary)),
    );
  }

  Widget _buildVehicleCard(String title, String details, String pricePerDay, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(0),
        borderRadius: 24,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.network(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.titleMedium),
                        const SizedBox(height: 4),
                        Text(details, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('$pricePerDay VND', style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary)),
                      Text('/ day', style: AppTextStyles.labelSmall),
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
