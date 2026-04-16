import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';

class ArLuggageMeasureScreen extends StatelessWidget {
  const ArLuggageMeasureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Mock Camera
      body: Stack(
        children: [
          // Simulated Camera Background
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', // Luggage photo
              fit: BoxFit.cover,
            ),
          ),
          
          // AR Measurement Box Overlay
          Center(
            child: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent, width: 3),
                color: Colors.greenAccent.withValues(alpha: 0.1),
              ),
              child: Stack(
                children: [
                  // Dimension Labels
                  Positioned(
                    top: -24,
                    left: 0,
                    right: 0,
                    child: Text('55 cm', textAlign: TextAlign.center, style: AppTextStyles.labelLarge.copyWith(color: Colors.greenAccent, shadows: [const Shadow(color: Colors.black, blurRadius: 4)])),
                  ),
                  Positioned(
                    left: -40,
                    top: 140,
                    child: Transform.rotate(
                      angle: -1.5708,
                      child: Text('35 cm', style: AppTextStyles.labelLarge.copyWith(color: Colors.greenAccent, shadows: [const Shadow(color: Colors.black, blurRadius: 4)])),
                    ),
                  ),
                ],
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

          // Airline Check Status
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: GlassContainer.dark(
              padding: const EdgeInsets.all(20),
              borderRadius: 24,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cabin Size Approved', style: AppTextStyles.titleMedium.copyWith(color: Colors.white)),
                        const SizedBox(height: 4),
                        Text('Fits Vietnam Airlines & Vietjet Air overhead bins perfectly.', style: AppTextStyles.bodySmall.copyWith(color: Colors.white70)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Measure Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  color: Colors.white30,
                ),
                child: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
