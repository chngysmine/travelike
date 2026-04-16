import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'dart:math';

class AiTripMemoryScreen extends StatelessWidget {
  const AiTripMemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Trip Memories AI', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.export_3, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            Text('Generating Magic Recap...', style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
            const SizedBox(height: 8),
            Text('Summer in Hoi An 2026', style: AppTextStyles.displayMedium.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            
            // Polaroids Stack Simulation
            SizedBox(
              height: 320,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildPolaroid(rotation: -pi/12, offset: const Offset(-20, 20), color: Colors.blueAccent),
                  _buildPolaroid(rotation: pi/10, offset: const Offset(20, -10), color: Colors.orangeAccent),
                  _buildPolaroid(rotation: -0.05, offset: const Offset(0, 0), color: Colors.pinkAccent),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // AI Summary Text
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.edit_2, color: AppColors.primary, size: 20),
                      const SizedBox(width: 8),
                      Text('AI Logbook', style: AppTextStyles.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "You explored 5 ancient pagodas, walked over 15,000 steps, and found your new favorite lantern cafe along the Hoai River. What an unforgettable journey!",
                    style: AppTextStyles.bodyMedium.copyWith(height: 1.5, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Highlights list
            Text('Key Highlights', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            _buildHighlightItem('Ate an authentic bowl of Cao Lau in the ancient town.'),
            _buildHighlightItem('Successfully bargained at the bustling Central Market.'),
            _buildHighlightItem('Took 450+ stunning photos of the colorful lanterns.'),
          ],
        ),
      ),
    );
  }

  Widget _buildPolaroid({required double rotation, required Offset offset, required Color color}) {
    return Transform.translate(
      offset: offset,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          width: 200,
          height: 240,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, spreadRadius: 2)],
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(Icons.image, size: 48, color: color),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('Hoi An Ancient Town', style: AppTextStyles.labelMedium.copyWith(color: Colors.black87)),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: AppTextStyles.bodyMedium)),
        ],
      ),
    );
  }
}
