import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AiPhotoEnhancerScreen extends StatelessWidget {
  const AiPhotoEnhancerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Magic Enhancer', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('Save', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            // Image Comparison Mockup
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      // "Original" Image (Dull gradient)
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF555555), Color(0xFF333333)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      // "Enhanced" Image (Vibrant gradient clipped to right half)
                      ClipRect(
                        child: Align(
                          alignment: Alignment.centerRight,
                          widthFactor: 0.5, // shows only right 50%
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.purple, Colors.orangeAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Slider Divider
                      const Center(
                        child: VerticalDivider(
                          color: Colors.white,
                          thickness: 4,
                          width: 4,
                        ),
                      ),
                      // Slider Thumb
                      Center(
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 8)],
                          ),
                          child: const Icon(Icons.code, color: Colors.black, size: 20),
                        ),
                      ),
                      
                      // Labels
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                          child: Text('Original', style: AppTextStyles.labelSmall),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              const Icon(Iconsax.magic_star, size: 12, color: Colors.white),
                              const SizedBox(width: 4),
                              Text('Enhanced', style: AppTextStyles.labelSmall),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Adjustments Panel
            GlassContainer.solid(
              padding: const EdgeInsets.symmetric(vertical: 24),
              borderRadius: 32, // Top curve and bottom curve, actually let's use only top curve
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('AI Styles', style: AppTextStyles.titleMedium),
                        const Icon(Iconsax.setting_4, color: AppColors.textPrimary),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildFilterOption('Auto Fix', true, [Colors.blue, Colors.cyan]),
                        _buildFilterOption('Golden Hour', false, [Colors.orange, Colors.deepOrange]),
                        _buildFilterOption('Cyberpunk', false, [Colors.purple, Colors.pink]),
                        _buildFilterOption('Cinematic', false, [Colors.teal, Colors.black87]),
                        _buildFilterOption('Vintage', false, [Colors.brown, Colors.orangeAccent]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Intensity Slider mockup
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Text('Intensity', style: AppTextStyles.labelMedium),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Slider(
                            value: 0.8,
                            onChanged: (v) {},
                            activeColor: AppColors.primary,
                            inactiveColor: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        Text('80%', style: AppTextStyles.labelMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String name, bool isSelected, List<Color> colors) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: colors),
              border: Border.all(
                color: isSelected ? Colors.white : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: AppTextStyles.labelSmall.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          )),
        ],
      ),
    );
  }
}
