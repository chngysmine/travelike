import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class VisaEmbassyScreen extends StatelessWidget {
  const VisaEmbassyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Visa & Embassies', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // E-Visa Status
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              color: AppColors.primaryDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vietnam e-Visa', style: AppTextStyles.titleMedium.copyWith(color: Colors.white)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                        child: const Text('APPROVED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Duration: 90 Days (Multiple Entry)', style: AppTextStyles.labelMedium.copyWith(color: Colors.white70)),
                  Text('Expires: Dec 31, 2026', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white)),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                    child: const Center(child: Text('View Document', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Your Nearest Embassy', style: AppTextStyles.titleLarge),
            const SizedBox(height: 16),

            // Embassy Info
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 20,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white12),
                          image: const DecorationImage(
                            image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/800px-Flag_of_the_United_States.svg.png'), // U.S Flag
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('U.S. Consulate General', style: AppTextStyles.titleSmall),
                            Text('Ho Chi Minh City, Vietnam', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32, color: Colors.white12),
                  _buildContactRow(Icons.location_on, '4 Le Duan Blvd, District 1, HCMC'),
                  const SizedBox(height: 12),
                  _buildContactRow(Icons.phone, '+84 28 3520 4200'),
                  const SizedBox(height: 12),
                  _buildContactRow(Icons.language, 'vn.usembassy.gov'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: AppTextStyles.bodyMedium)),
      ],
    );
  }
}
