import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TripCollabHubScreen extends StatelessWidget {
  const TripCollabHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Trip Collab Hub', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.user_cirlce_add, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Header Image
            GlassContainer.solid(
              padding: const EdgeInsets.all(0),
              borderRadius: 24,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    child: Image.network('https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', height: 160, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text('Vietnam Backpacking Squad 🇻🇳', style: AppTextStyles.titleLarge),
                         const SizedBox(height: 8),
                         Row(
                           children: [
                             const Icon(Icons.calendar_month, size: 16, color: AppColors.textSecondary),
                             const SizedBox(width: 4),
                             Text('Oct 10 - Oct 25 • 4 Travelers', style: AppTextStyles.labelSmall),
                           ],
                         ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Collab Tools
            Text('Workspace', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildToolBtn(Iconsax.note_2, 'Shared Notes', AppColors.primary)),
                const SizedBox(width: 16),
                Expanded(child: _buildToolBtn(Iconsax.folder, 'Documents', Colors.amber)),
                const SizedBox(width: 16),
                Expanded(child: _buildToolBtn(Iconsax.camera, 'Photo Pool', Colors.blue)),
              ],
            ),
            const SizedBox(height: 24),

            // Pinned Ideas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pinned Ideas', style: AppTextStyles.titleSmall),
                const Icon(Icons.add_circle, color: AppColors.primary),
              ],
            ),
            const SizedBox(height: 16),
            _buildIdeaCard('Ha Long Bay 2-day Cruise', 'Added by Linh • 4 votes', 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800'),
            _buildIdeaCard('Train Street Cafe, Hanoi', 'Added by Khoa • 3 votes', 'https://images.unsplash.com/photo-1533050487297-09b450131914?w=800'),
            
            const SizedBox(height: 24),
            // Shared Budget Status
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 20,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.wallet, color: Colors.green),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Group Budget', style: AppTextStyles.labelMedium),
                        Text('\$1,200 deposited / \$2,000', style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textTertiary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolBtn(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }

  Widget _buildIdeaCard(String title, String subtitle, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
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
                  Text(subtitle, style: AppTextStyles.labelSmall),
                ],
              ),
            ),
            const Icon(Icons.push_pin, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
