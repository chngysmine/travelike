import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class TrainBusTicketScreen extends StatelessWidget {
  const TrainBusTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Ground Transport', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Search Form
            GlassContainer.dark(
              padding: const EdgeInsets.all(20),
              borderRadius: 24,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.trip_origin, color: AppColors.primary, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('From', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                            Text('Hanoi (HAN)', style: AppTextStyles.titleMedium.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                      const Icon(Icons.swap_vert, color: Colors.white54),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(left: 8), child: Divider(color: Colors.white12, height: 24)),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.accentTeal, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('To', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                            Text('Sapa (Lao Cai)', style: AppTextStyles.titleMedium.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Search Routes', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Available Routes (Oct 16)', style: AppTextStyles.titleLarge),
            const SizedBox(height: 16),

            // Train Card
            _buildTicketCard(
              type: 'Sleeper Train',
              company: 'Vietnam Railways (SP1)',
              departure: '21:30',
              arrival: '05:35',
              duration: '8h 5m',
              price: '650,000 VND',
              seatsLeft: 12,
              icon: Icons.train,
            ),

            // Limousine Bus Card
            _buildTicketCard(
              type: 'VIP Limousine Van',
              company: 'Eco Sapa Bus',
              departure: '07:00',
              arrival: '13:00',
              duration: '6h 0m',
              price: '450,000 VND',
              seatsLeft: 4,
              icon: Icons.directions_bus,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketCard({
    required String type,
    required String company,
    required String departure,
    required String arrival,
    required String duration,
    required String price,
    required int seatsLeft,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(20),
        borderRadius: 20,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: AppColors.primary, size: 24),
                    const SizedBox(width: 8),
                    Text(type, style: AppTextStyles.labelMedium),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.redAccent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text('Only $seatsLeft left', style: AppTextStyles.labelSmall.copyWith(color: Colors.redAccent, fontSize: 10)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(alignment: Alignment.centerLeft, child: Text(company, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary))),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(departure, style: AppTextStyles.titleLarge),
                      Text('Hanoi', style: AppTextStyles.labelSmall),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(duration, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textTertiary)),
                    Container(height: 2, width: 40, color: Colors.grey.withValues(alpha: 0.3), margin: const EdgeInsets.symmetric(vertical: 4)),
                    const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(arrival, style: AppTextStyles.titleLarge),
                      Text('Sapa', style: AppTextStyles.labelSmall),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.black12),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(price, style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12)),
                  child: const Text('Select', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
