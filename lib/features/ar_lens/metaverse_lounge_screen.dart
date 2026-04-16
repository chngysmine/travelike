import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MetaverseLoungeScreen extends StatelessWidget {
  const MetaverseLoungeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1722),
      body: Stack(
        children: [
          // Metaverse Environment Background
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.network(
                'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', // Sci-fi / Metaverse room
                fit: BoxFit.cover,
              ),
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
                      const Icon(Icons.wifi, color: Colors.greenAccent, size: 16),
                      const SizedBox(width: 8),
                      Text('Noi Bai Terminal 2 Lounge', style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black45),
                  child: IconButton(
                    icon: const Icon(Iconsax.profile_2user, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          
          // Virtual Avatars
          _buildAvatar(top: 250, left: 60, imageUrl: 'https://i.pravatar.cc/150?u=1', name: 'Khoa', message: 'Anyone sharing a taxi to Old Quarter?'),
          _buildAvatar(top: 400, right: 40, imageUrl: 'https://i.pravatar.cc/150?u=2', name: 'Linh', message: 'Flight to Da Nang delayed 1h 😔'),
          _buildAvatar(top: 300, right: 120, imageUrl: 'https://i.pravatar.cc/150?u=3', name: 'You', isMe: true),

          // Bottom Interaction Bar
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GlassContainer.dark(
              padding: const EdgeInsets.all(16),
              borderRadius: 32,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Icon(Iconsax.microphone_2, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(20)),
                      child: Text('Say something to the lounge...', style: AppTextStyles.bodyMedium.copyWith(color: Colors.white54)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    child: const Icon(Iconsax.send_1, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar({required double top, double? left, double? right, required String imageUrl, required String name, String? message, bool isMe = false}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Column(
        children: [
          if (message != null) ...[
            GlassContainer.dark(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              borderRadius: 16,
              child: Text(message, style: AppTextStyles.labelSmall.copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 8),
          ],
          Container(
            width: isMe ? 64 : 48,
            height: isMe ? 64 : 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isMe ? AppColors.accentTeal : Colors.white, width: 2),
              image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
              boxShadow: isMe ? [BoxShadow(color: AppColors.accentTeal.withValues(alpha: 0.5), blurRadius: 20)] : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(name, style: AppTextStyles.labelMedium.copyWith(color: isMe ? AppColors.accentTeal : Colors.white)),
        ],
      ),
    );
  }
}
