import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class PublicAmenityFinderScreen extends StatelessWidget {
  const PublicAmenityFinderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Public Amenities', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.6,
                child: Image.network(
                  'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Map markers
            _buildMarker(top: 200, left: 100, icon: Icons.wc, color: Colors.blueAccent),
            _buildMarker(top: 300, right: 80, icon: Icons.water_drop, color: Colors.blue),
            _buildMarker(top: 400, left: 50, icon: Icons.wifi, color: Colors.green),

            // Top Search Bar
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for Restrooms in Da Nang...',
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: AppColors.primary),
                  ),
                ),
              ),
            ),

            // Filters
            Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('Restrooms', Icons.wc, true),
                    _buildFilterChip('Water Stations', Icons.water_drop, false),
                    _buildFilterChip('Free WiFi', Icons.wifi, false),
                    _buildFilterChip('Trash Bins', Icons.delete, false),
                  ],
                ),
              ),
            ),

            // Bottom Results Sheet
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: GlassContainer.solid(
                padding: const EdgeInsets.all(20),
                borderRadius: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(height: 20),
                    _buildAmenityResult(
                      'Public Restroom - My Khe Beach',
                      '250m away • Paid (5,000 VND)',
                      'Clean • Attendant on duty',
                    ),
                    const Divider(height: 24, color: Colors.white12),
                    _buildAmenityResult(
                      'Free Wifi - Lotteria Center',
                      '400m away • Free Access',
                      'High Speed • Open 24/7',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarker({required double top, double? left, double? right, required IconData icon, required Color color}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.black45,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildAmenityResult(String title, String subtitle, String status) {
    return Row(
      children: [
        const Icon(Icons.location_on, color: AppColors.primary, size: 30),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.titleSmall),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: 4),
              Text(status, style: AppTextStyles.bodySmall.copyWith(color: Colors.greenAccent)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: const Icon(Icons.directions, color: Colors.white),
        ),
      ],
    );
  }
}
