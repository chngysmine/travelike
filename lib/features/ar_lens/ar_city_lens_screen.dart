import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ArCityLensScreen extends StatelessWidget {
  const ArCityLensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Simulating camera feed
      body: Stack(
        children: [
          // Simulated Camera Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E2A38), Color(0xFF0F1722)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // AR Targeting Reticle
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
              ),
              child: Center(
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                ),
              ),
            ),
          ),
          
          // Floating AR Landmarks
          _buildArLabel(top: 150, left: 40, name: 'Bitexco Tower', distance: '1.2 km', icon: Iconsax.building_3, color: Colors.orangeAccent),
          _buildArLabel(top: 300, right: 30, name: 'Ben Thanh Market', distance: '500 m', icon: Iconsax.map, color: Colors.blueAccent),
          _buildArLabel(top: 500, left: 60, name: 'Notre Dame Cathedral', distance: '2.5 km', icon: Iconsax.tree, color: Colors.greenAccent),

          // App Bar
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black45),
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                GlassContainer.dark(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  borderRadius: 20,
                  child: Row(
                    children: [
                      const Icon(Iconsax.radar_2, color: AppColors.accentTeal, size: 16),
                      const SizedBox(width: 8),
                      Text('Scanning City...', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black45),
                  child: IconButton(
                    icon: const Icon(Iconsax.setting_4, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Category Selector
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GlassContainer.dark(
              padding: const EdgeInsets.symmetric(vertical: 16),
              borderRadius: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomTap(Iconsax.building, 'Sights', true),
                  _buildBottomTap(Iconsax.coffee, 'Cafes', false),
                  _buildBottomTap(Iconsax.shopping_bag, 'Shops', false),
                  _buildBottomTap(Iconsax.bus, 'Transit', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArLabel({double? top, double? left, double? right, double? bottom, required String name, required String distance, required IconData icon, required Color color}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GlassContainer.dark(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            borderRadius: 16,
            child: Row(
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                    Text(distance, style: AppTextStyles.labelSmall.copyWith(color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 2,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white70, Colors.transparent],
              ),
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomTap(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isSelected ? AppColors.accentTeal : Colors.white54, size: 24),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.labelSmall.copyWith(color: isSelected ? AppColors.accentTeal : Colors.white54)),
      ],
    );
  }
}
