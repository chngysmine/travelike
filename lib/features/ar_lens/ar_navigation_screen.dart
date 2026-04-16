import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';

class ArNavigationScreen extends StatelessWidget {
  const ArNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Mock Camera
      body: Stack(
        children: [
          // Background representing street camera
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2C3E50), Color(0xFF000000)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          
          // Floating 3D AR Arrows
          Positioned(
            bottom: 250,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Opacity(
                  opacity: 0.3,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002) // perspective
                      ..rotateX(1.2), // tilt
                    alignment: FractionalOffset.center,
                    child: const Icon(Icons.keyboard_double_arrow_up_rounded, size: 100, color: AppColors.primary),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateX(1.2),
                    alignment: FractionalOffset.center,
                    child: const Icon(Icons.keyboard_double_arrow_up_rounded, size: 140, color: AppColors.primary),
                  ),
                ),
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateX(1.2),
                  alignment: FractionalOffset.center,
                  child: const Icon(Icons.keyboard_double_arrow_up_rounded, size: 200, color: AppColors.primary),
                ),
              ],
            ),
          ),

          // AR Floating Label in world space
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Center(
              child: GlassContainer.dark(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                borderRadius: 20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on, color: Colors.redAccent),
                    const SizedBox(width: 8),
                    Text('Hoan Kiem Lake - 200m', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                  ],
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
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          
          // Navigation Dashboard
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GlassContainer.dark(
              padding: const EdgeInsets.all(24),
              borderRadius: 32,
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.turn_right_rounded, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Turn right onto Dinh Tien Hoang St', style: AppTextStyles.titleMedium.copyWith(color: Colors.white)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text('3 mins', style: AppTextStyles.labelMedium.copyWith(color: AppColors.accentTeal)),
                            const SizedBox(width: 8),
                            Text('• 200m left', style: AppTextStyles.labelSmall.copyWith(color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
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
