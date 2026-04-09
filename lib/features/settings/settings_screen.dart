import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20)),
                      const SizedBox(width: 12),
                      Text('Personal Center', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms),
                // Profile Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12)]),
                  child: Row(children: [
                    CircleAvatar(radius: 32, backgroundImage: const CachedNetworkImageProvider(MockData.userAvatar)),
                    const SizedBox(width: 16),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(MockData.userFullName, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                      Text(MockData.userEmail, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textTertiary)),
                    ])),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Iconsax.edit, size: 18, color: AppColors.primary),
                    ),
                  ]),
                ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
                const SizedBox(height: 24),
                // Settings items
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12)]),
                  child: Column(
                    children: MockData.settingsItems.asMap().entries.map((entry) {
                      final item = entry.value;
                      final isLast = entry.key == MockData.settingsItems.length - 1;
                      return Column(children: [
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          leading: Text(item['icon'], style: const TextStyle(fontSize: 24)),
                          title: Text(item['title'], style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500, color: isLast ? AppColors.error : AppColors.textPrimary)),
                          subtitle: (item['subtitle'] as String).isNotEmpty ? Text(item['subtitle'], style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)) : null,
                          trailing: isLast ? null : const Icon(Icons.chevron_right, color: AppColors.textTertiary),
                          onTap: () {
                            if (isLast) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (_) => const LoginScreen()),
                                (route) => false,
                              );
                            }
                          },
                        ),
                        if (!isLast) Divider(height: 1, indent: 60, color: Colors.grey.shade100),
                      ]);
                    }).toList(),
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
                const SizedBox(height: 24),
                Text('Travelike v1.0.0', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                const SizedBox(height: 8),
                Text('Made with ❤️ by Team 5', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
