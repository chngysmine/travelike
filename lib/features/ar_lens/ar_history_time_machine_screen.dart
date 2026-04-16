import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ArHistoryTimeMachineScreen extends StatefulWidget {
  const ArHistoryTimeMachineScreen({super.key});

  @override
  State<ArHistoryTimeMachineScreen> createState() => _ArHistoryTimeMachineScreenState();
}

class _ArHistoryTimeMachineScreenState extends State<ArHistoryTimeMachineScreen> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    // Generate an overlay color based on slider.
    // 0 = 70 AD (Sepia/Gold), 1 = Present (Clear)
    Color overlayColor = Color.lerp(Colors.orange.withValues(alpha: 0.6), Colors.transparent, _sliderValue) ?? Colors.transparent;
    String eraText = _sliderValue < 0.3 ? '1010 AD - Thang Long' : (_sliderValue < 0.7 ? '1920s - French Colonial' : 'Present Day');

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Simulated Building Camera Base
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]), // Fallback
            ),
          ),

          // Colored Era Overlay
          Positioned.fill(
            child: Container(
              color: overlayColor,
            ),
          ),
          
          // Glitch / Scanlines Mockup Overlay
          if (_sliderValue < 0.9)
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.1],
                    ),
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
          
          // Year Indicator
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: GlassContainer.dark(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                borderRadius: 24,
                child: Text(eraText, style: AppTextStyles.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          
          // Floating Info Marker
          if (_sliderValue < 0.3)
            Positioned(
              top: 300,
              left: 50,
              child: GlassContainer.dark(
                padding: const EdgeInsets.all(16),
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.history_edu, color: Colors.amber),
                        const SizedBox(width: 8),
                        Text('Historical Fact', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Emperor Ly Thai To moved the capital to Thang Long (now Hanoi) in 1010 AD.', style: AppTextStyles.bodySmall.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ),

          // Slider Panel
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GlassContainer.dark(
              padding: const EdgeInsets.all(24),
              borderRadius: 32,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Past', style: AppTextStyles.labelMedium.copyWith(color: Colors.white54)),
                      const Icon(Iconsax.timer_1, color: AppColors.accentGold),
                      Text('Present', style: AppTextStyles.labelMedium.copyWith(color: Colors.white54)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: AppColors.accentGold,
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.white,
                      overlayColor: AppColors.accentGold.withValues(alpha: 0.2),
                    ),
                    child: Slider(
                      value: _sliderValue,
                      onChanged: (v) => setState(() => _sliderValue = v),
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
