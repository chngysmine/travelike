import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class SosEmergencyScreen extends StatelessWidget {
  const SosEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('SOS Emergency', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Big SOS Button
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent.withValues(alpha: 0.2),
                  boxShadow: [BoxShadow(color: Colors.red.withValues(alpha: 0.3), blurRadius: 40, spreadRadius: 10)],
                ),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Center(
                      child: Text('SOS', style: AppTextStyles.displayLarge.copyWith(color: Colors.white, fontSize: 64)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Hold for 3 seconds to alert local authorities and your emergency contacts.', textAlign: TextAlign.center, style: AppTextStyles.bodyMedium),
            const SizedBox(height: 48),

            Text('Vietnam Local Hotlines', style: AppTextStyles.titleLarge),
            const SizedBox(height: 16),
            
            _buildHotlineCard('113', 'Police', Icons.local_police, Colors.blue),
            _buildHotlineCard('114', 'Fire Department', Icons.fire_extinguisher, Colors.orange),
            _buildHotlineCard('115', 'Ambulance', Icons.local_hospital, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildHotlineCard(String number, String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(20),
        borderRadius: 20,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.2), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.titleSmall),
                  Text('Dial $number', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.call, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
