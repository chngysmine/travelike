import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class AccessibilityFilterScreen extends StatefulWidget {
  const AccessibilityFilterScreen({super.key});

  @override
  State<AccessibilityFilterScreen> createState() => _AccessibilityFilterScreenState();
}

class _AccessibilityFilterScreenState extends State<AccessibilityFilterScreen> {
  final Map<String, bool> _filters = {
    'Wheelchair Accessible': true,
    'Step-free Access': false,
    'Braille Signs': false,
    'Sign Language Tour': false,
    'Low Noise Areas': true,
  };

  void _toggle(String key) {
    setState(() {
      _filters[key] = !_filters[key]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Accessibility Mode', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Intro
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 20,
              child: Row(
                children: [
                  const Icon(Icons.accessible_forward, color: AppColors.primary, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Travel Without Limits', style: AppTextStyles.titleMedium),
                        const SizedBox(height: 4),
                        Text('We will filter places in Vietnam based on your accessibility needs.', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Your Preferences', style: AppTextStyles.titleMedium),
            const SizedBox(height: 16),
            ..._filters.keys.map((key) => _buildFilterTile(key, _filters[key]!)),

            const SizedBox(height: 32),
            Text('Recommended in Da Nang', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            _buildRecommendation('Dragon Bridge Viewpoint', 'Wheelchair ramps available. Flat paths.', 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800'),
            _buildRecommendation('My Khe Beach Walkway', 'Paved boardwalks for easy access.', 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTile(String title, bool val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer.solid(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        borderRadius: 16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.labelMedium),
            Switch(
              value: val,
              onChanged: (_) => _toggle(title),
              activeTrackColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendation(String title, String desc, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(12),
        borderRadius: 16,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall),
                  Text(desc, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textTertiary)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
