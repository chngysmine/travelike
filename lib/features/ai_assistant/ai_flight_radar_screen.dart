import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'dart:math';

class AiFlightRadarScreen extends StatelessWidget {
  const AiFlightRadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Airspace Radar', style: AppTextStyles.titleMedium),
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: GlassContainer.solid(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  borderRadius: 16,
                  child: Row(
                    children: [
                      const Icon(Iconsax.search_normal, color: AppColors.textSecondary, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Search flight number (e.g., VN234)',
                            hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Radar UI Simulation
              Stack(
                alignment: Alignment.center,
                children: [
                  _buildRadarCircle(300, AppColors.primary.withValues(alpha: 0.1)),
                  _buildRadarCircle(220, AppColors.primary.withValues(alpha: 0.2)),
                  _buildRadarCircle(140, AppColors.primary.withValues(alpha: 0.3)),
                  _buildRadarCircle(60, AppColors.primary.withValues(alpha: 0.5)),
                  
                  // Scanning Sweep
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.primary.withValues(alpha: 0.1),
                          AppColors.primary.withValues(alpha: 0.6),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 0.9, 1.0],
                      ),
                    ),
                  ),

                  // User center marker
                  const Icon(Iconsax.location, color: AppColors.accentTeal, size: 32),

                  // Airplane Blips
                  _buildAirplaneBlip(dx: -80, dy: -60, rotation: pi/4, flightCode: 'QA82'),
                  _buildAirplaneBlip(dx: 90, dy: -30, rotation: pi/2, flightCode: 'VJ102'),
                  _buildAirplaneBlip(dx: -40, dy: 100, rotation: 3*pi/4, flightCode: 'VN322'),
                  _buildAirplaneBlip(dx: 120, dy: 80, rotation: pi, flightCode: 'EK405'),
                ],
              ),
              const SizedBox(height: 40),

              // Bottom Sheet of Tracked Flights
              Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard.withValues(alpha: 0.4),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tracked Flights nearby', style: AppTextStyles.titleMedium),
                    const SizedBox(height: 16),
                    _buildFlightItem(code: 'VN322', from: 'SGN', to: 'HAN', status: 'On Time', time: '14:30', color: Colors.green),
                    _buildFlightItem(code: 'VJ102', from: 'DAD', to: 'SGN', status: 'In Air', time: '12:15', color: Colors.blueAccent),
                    _buildFlightItem(code: 'EK405', from: 'DXB', to: 'SGN', status: 'Delayed', time: '18:45', color: Colors.orange),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadarCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.5),
      ),
    );
  }

  Widget _buildAirplaneBlip({required double dx, required double dy, required double rotation, required String flightCode}) {
    return Transform.translate(
      offset: Offset(dx, dy),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(flightCode, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          Transform.rotate(
            angle: rotation,
            child: const Icon(Icons.flight, color: AppColors.textPrimary, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightItem({
    required String code,
    required String from,
    required String to,
    required String status,
    required String time,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(16),
        borderRadius: 16,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.flight_takeoff, color: AppColors.textPrimary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(code, style: AppTextStyles.titleSmall),
                      const Spacer(),
                      Text(time, style: AppTextStyles.titleSmall),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text('$from ', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
                      const Icon(Icons.arrow_right_alt, color: AppColors.textSecondary, size: 16),
                      Text(' $to', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(status, style: AppTextStyles.labelSmall.copyWith(color: color)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
