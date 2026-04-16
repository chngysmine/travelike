import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';

class ArVirtualGuideScreen extends StatelessWidget {
  const ArVirtualGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Mock Camera
      body: Stack(
        children: [
          // Background image (Imperial Hue)
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
              fit: BoxFit.cover,
            ),
          ),
          
          // Virtual Hologram Overlay
          Positioned(
            bottom: 100,
            right: 20,
            child: Opacity(
              opacity: 0.85,
              child: Container(
                width: 180,
                height: 350,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1528127269322-539801943592?w=800'), // Person silhouette
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(90),
                  boxShadow: [
                    BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 40, spreadRadius: 10),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    gradient: LinearGradient(
                      colors: [AppColors.primary.withValues(alpha: 0.2), Colors.transparent, AppColors.primary.withValues(alpha: 0.4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Floating Speech Bubble
          Positioned(
            bottom: 350,
            left: 20,
            right: 150,
            child: GlassContainer.dark(
              padding: const EdgeInsets.all(16),
              borderRadius: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('AI Guide: Minh', style: AppTextStyles.labelSmall.copyWith(color: AppColors.accentGold)),
                  const SizedBox(height: 4),
                  Text('"Welcome to the Hue Imperial City! This palace was home to the Nguyen Dynasty for 143 years..."', 
                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.white, fontStyle: FontStyle.italic),
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
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          
          // Controls
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GlassContainer.solid(
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              borderRadius: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlBtn(Icons.pause, 'Pause'),
                  _buildControlBtn(Icons.replay_10, 'Replay'),
                  _buildControlBtn(Icons.translate, 'Translate'),
                  _buildControlBtn(Icons.subtitles, 'Subtitles'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlBtn(IconData icon, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 4),
        Text(text, style: AppTextStyles.labelSmall.copyWith(color: Colors.white70)),
      ],
    );
  }
}
