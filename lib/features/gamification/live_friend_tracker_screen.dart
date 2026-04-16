import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LiveFriendTrackerScreen extends StatelessWidget {
  const LiveFriendTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EDF5),
      body: Stack(
        children: [
          // Simulated Map Background (Street view)
          Positioned.fill(
            child: Opacity(
              opacity: 0.8,
              child: Image.network(
                'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', // City/Map vibe
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Friend Markers
          _buildFriendMarker(top: 200, left: 100, name: 'Khoa', battery: 85, isMoving: true),
          _buildFriendMarker(top: 350, right: 80, name: 'Linh', battery: 20, isWarning: true),
          
          // User Marker
          Positioned(
            top: 400,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 20, spreadRadius: 5)],
              ),
              child: const Icon(Icons.my_location, color: Colors.white),
            ),
          ),
          
          // App Bar
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black45),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                GlassContainer.dark(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  borderRadius: 20,
                  child: Row(
                    children: [
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      Text('Tracking Squad in Hanoi', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(width: 48), // balance padding
              ],
            ),
          ),
          
          // Bottom Sheet Friend List
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 32,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Squad Status', style: AppTextStyles.titleMedium),
                      const Icon(Iconsax.radar_1, color: AppColors.primary),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFriendStatusRow('Khoa', 'Walking to Hoan Kiem Lake', '450m away', 85, Icons.directions_walk),
                  const Divider(height: 24, thickness: 1, color: Colors.black12),
                  _buildFriendStatusRow('Linh', 'At Note Coffee', '1.2km away', 20, Icons.local_cafe, isLowBattery: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendMarker({required double top, double? left, double? right, required String name, required int battery, bool isMoving = false, bool isWarning = false}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isWarning ? Colors.redAccent : Colors.black87,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(name, style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
                const SizedBox(width: 6),
                Icon(
                  battery <= 20 ? Icons.battery_alert : (battery >= 80 ? Icons.battery_full : Icons.battery_std),
                  color: battery <= 20 ? Colors.white : Colors.greenAccent,
                  size: 12,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=$name'),
            ),
          ),
          if (isMoving)
             const Padding(
               padding: EdgeInsets.only(top: 4),
               child: Icon(Icons.directions_walk, size: 16, color: Colors.black87),
             ),
        ],
      ),
    );
  }

  Widget _buildFriendStatusRow(String name, String activity, String distance, int battery, IconData icon, {bool isLowBattery = false}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=$name'),
          radius: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name, style: AppTextStyles.titleSmall),
                  const SizedBox(width: 8),
                  Icon(icon, size: 14, color: AppColors.textSecondary),
                ],
              ),
              const SizedBox(height: 4),
              Text(activity, style: AppTextStyles.bodySmall),
              Text(distance, style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.battery_charging_full, color: isLowBattery ? Colors.redAccent : Colors.greenAccent, size: 16),
            const SizedBox(height: 4),
            Text('$battery%', style: AppTextStyles.labelSmall.copyWith(color: isLowBattery ? Colors.redAccent : AppColors.textSecondary)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Ping', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}
