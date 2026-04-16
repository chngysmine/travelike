import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TravelBuddyMatcherScreen extends StatelessWidget {
  const TravelBuddyMatcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Find Travel Buddy', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.setting_4, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text('Searching for backpackers heading to Da Lat', style: AppTextStyles.bodyMedium),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Swipe Card Container
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: AppColors.elevatedShadow,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', // Traveler image
                            fit: BoxFit.cover,
                          ),
                        ),
                        
                        // Gradient bottom
                        Positioned(
                          bottom: 0, left: 0, right: 0, height: 300,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black87, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        
                        // User Info
                        Positioned(
                          bottom: 30,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(color: Colors.greenAccent.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(12)),
                                child: Text('85% Trip Match', style: AppTextStyles.labelSmall.copyWith(color: Colors.black87, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 12),
                              Text('Hoang Linh, 24', style: AppTextStyles.displayMedium.copyWith(color: Colors.white)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                                  const SizedBox(width: 8),
                                  Text('Oct 20 - Nov 1', style: AppTextStyles.labelMedium.copyWith(color: Colors.white70)),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildInterestChip('Photography'),
                                  _buildInterestChip('Coffee Hopping'),
                                  _buildInterestChip('Street Food'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCircleBtn(Icons.close_rounded, Colors.redAccent, false),
                  _buildCircleBtn(Icons.star_rounded, Colors.blueAccent, false),
                  _buildCircleBtn(Icons.favorite_rounded, Colors.greenAccent, true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(title, style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
    );
  }

  Widget _buildCircleBtn(IconData icon, Color color, bool isLarge) {
    final size = isLarge ? 80.0 : 60.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: AppColors.cardShadow,
      ),
      child: Center(
        child: Icon(icon, color: color, size: isLarge ? 40 : 30),
      ),
    );
  }
}
