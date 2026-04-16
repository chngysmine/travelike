import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';

class ArHotelPortalScreen extends StatelessWidget {
  const ArHotelPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Mock Camera
      body: Stack(
        children: [
          // Background representing outside
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2A3A4A), Color(0xFF101820)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          
          // The AR Portal Door
          Center(
            child: Container(
              width: 250,
              height: 480,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(125)),
                border: Border.all(color: AppColors.accentGold, width: 4),
                boxShadow: [
                  BoxShadow(color: AppColors.accentGold.withValues(alpha: 0.3), blurRadius: 40, spreadRadius: 10),
                ],
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(125)),
                  gradient: LinearGradient(
                    colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Icon(Icons.sensor_door_outlined, color: AppColors.accentGold, size: 40),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Text('Step Inside InterContinental Hanoi', 
                        style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Instructions Overlay
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: GlassContainer.dark(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                borderRadius: 24,
                child: Text('Walk forward to enter the Presidential Suite', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
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
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Footer info
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GlassContainer.solid(
              color: Colors.black87,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('InterContinental Hanoi Landmark72', style: AppTextStyles.titleMedium.copyWith(color: Colors.white)),
                        Text('From \$200 / night', style: AppTextStyles.bodySmall.copyWith(color: Colors.white70)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
                    child: Text('Book', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
