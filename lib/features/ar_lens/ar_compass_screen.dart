import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'dart:math';

class ArCompassScreen extends StatelessWidget {
  const ArCompassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Simulated Camera
      body: Stack(
        children: [
          // Background Gradient to simulate depth
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [Color(0xFF263238), Colors.black],
                  radius: 0.8,
                ),
              ),
            ),
          ),
          
          // App Bar
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black45),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          
          // Top Info
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text('34° N', style: AppTextStyles.displayLarge.copyWith(color: Colors.white, fontSize: 40)),
                  Text('Heading North-East', style: AppTextStyles.labelMedium.copyWith(color: AppColors.accentTeal)),
                ],
              ),
            ),
          ),

          // Central Compass UI
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer Ring
                Container(
                  width: 320,
                  height: 320,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1),
                  ),
                  child: const CircularProgressIndicator(value: 1, strokeWidth: 1, color: Colors.white12),
                ),
                
                // Tick Marks Ring
                Transform.rotate(
                  angle: pi / 6, // Simulated rotation
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                    ),
                    child: Stack(
                      children: [
                        _buildCompassTick(Alignment.topCenter, 'N', Colors.redAccent),
                        _buildCompassTick(Alignment.bottomCenter, 'S', Colors.white70),
                        _buildCompassTick(Alignment.centerRight, 'E', Colors.white70),
                        _buildCompassTick(Alignment.centerLeft, 'W', Colors.white70),
                      ],
                    ),
                  ),
                ),
                
                // Inner Target glass
                GlassContainer.dark(
                  width: 120,
                  height: 120,
                  borderRadius: 60,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.navigation_rounded, color: AppColors.accentTeal, size: 32),
                        const SizedBox(height: 4),
                        Text('142m', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                        Text('to Hotel', style: AppTextStyles.labelSmall.copyWith(color: Colors.white70)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Action Panel
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  child: GlassContainer.dark(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    borderRadius: 24,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Iconsax.location_add, color: Colors.white),
                        const SizedBox(height: 8),
                        Text('Drop Pin', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GlassContainer.dark(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    borderRadius: 24,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Iconsax.map_1, color: AppColors.accentTeal),
                        const SizedBox(height: 8),
                        Text('Open Map', style: AppTextStyles.labelMedium.copyWith(color: AppColors.accentTeal)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompassTick(Alignment alignment, String label, Color color) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(label, style: AppTextStyles.titleMedium.copyWith(color: color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
