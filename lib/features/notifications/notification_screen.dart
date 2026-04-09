import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20)),
                    const SizedBox(width: 12),
                    Text('Notifications', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    TextButton(onPressed: () {}, child: Text('Mark all read', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary))),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: MockData.notifications.length,
                  itemBuilder: (context, index) {
                    final n = MockData.notifications[index];
                    final isUnread = !(n['read'] as bool);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isUnread ? AppColors.primarySurface : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: isUnread ? Border.all(color: AppColors.primary.withValues(alpha: 0.15)) : null,
                      ),
                      child: Row(
                        children: [
                          Stack(children: [
                            CircleAvatar(radius: 24, backgroundImage: CachedNetworkImageProvider(n['avatar'])),
                            Positioned(bottom: 0, right: 0, child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                              child: Icon(_getIcon(n['type']), size: 14, color: _getColor(n['type'])),
                            )),
                          ]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              RichText(text: TextSpan(children: [
                                TextSpan(text: n['user'], style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                TextSpan(text: ' ${n['text']}', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                              ])),
                              const SizedBox(height: 4),
                              Text(n['time'], style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                            ]),
                          ),
                          if (isUnread) Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                        ],
                      ),
                    ).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'like': return Icons.favorite;
      case 'comment': return Iconsax.message;
      case 'follow': return Iconsax.user_add;
      case 'event': return Iconsax.calendar_1;
      case 'booking': return Iconsax.airplane;
      case 'share': return Iconsax.share;
      default: return Iconsax.notification;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case 'like': return Colors.red;
      case 'comment': return AppColors.chipBlue;
      case 'follow': return AppColors.chipPurple;
      case 'event': return AppColors.chipOrange;
      case 'booking': return AppColors.chipGreen;
      case 'share': return AppColors.chipTeal;
      default: return AppColors.textSecondary;
    }
  }
}
