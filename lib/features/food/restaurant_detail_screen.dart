import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Map<String, dynamic> restaurant;
  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final dishes = restaurant['dishes'] as List<Map<String, dynamic>>;
    final reviews = restaurant['reviews'] as List<Map<String, dynamic>>;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20)),
                      const Spacer(),
                      const Icon(Icons.share_outlined, size: 20),
                      const SizedBox(width: 16),
                      const Icon(Icons.favorite_border, size: 20),
                    ],
                  ),
                ),
                // Name + Rating
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(child: Text(restaurant['name'], style: GoogleFonts.playfairDisplay(fontSize: 26, fontWeight: FontWeight.w700))),
                      Row(children: [
                        const Icon(Icons.star_rounded, size: 22, color: AppColors.accentGold),
                        const SizedBox(width: 4),
                        Text('${restaurant['rating']}', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700)),
                      ]),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 16),
                // Image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(imageUrl: restaurant['image'], height: 200, width: double.infinity, fit: BoxFit.cover),
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
                const SizedBox(height: 20),
                // Info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _InfoRow(icon: Iconsax.location, text: restaurant['address']),
                    const SizedBox(height: 8),
                    _InfoRow(icon: Iconsax.clock, text: 'Hours: ${restaurant['hours']}'),
                    const SizedBox(height: 8),
                    _InfoRow(icon: Iconsax.call, text: 'Phone: ${restaurant['phone']}'),
                  ]),
                ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
                const SizedBox(height: 24),
                // Reviews
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('User Reviews', style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 12),
                if (reviews.isNotEmpty) SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final r = reviews[index];
                      return Container(
                        width: 260,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(16)),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            CircleAvatar(radius: 16, backgroundImage: CachedNetworkImageProvider(r['avatar'])),
                            const SizedBox(width: 8),
                            Expanded(child: Text(r['user'], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600))),
                            ...List.generate(r['rating'], (_) => const Icon(Icons.star, size: 14, color: AppColors.accentGold)),
                          ]),
                          const SizedBox(height: 8),
                          Text(r['text'], maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                          const Spacer(),
                          Text(r['date'], style: GoogleFonts.inter(fontSize: 11, color: AppColors.textTertiary)),
                        ]),
                      );
                    },
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
                const SizedBox(height: 24),
                // Recommended Dishes
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text('Recommended Dishes', style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w700)),
                      const Spacer(),
                      const Icon(Icons.chevron_left, color: AppColors.textTertiary),
                      const Icon(Icons.chevron_right, color: AppColors.textPrimary),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: dishes.length,
                    itemBuilder: (context, index) {
                      final d = dishes[index];
                      return Container(
                        width: 130,
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          ClipRRect(borderRadius: BorderRadius.circular(16), child: CachedNetworkImage(imageUrl: d['image'], height: 110, width: 130, fit: BoxFit.cover)),
                          const SizedBox(height: 6),
                          Text(d['name'], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                        ]),
                      );
                    },
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 18, color: AppColors.primary),
      const SizedBox(width: 8),
      Expanded(child: Text(text, style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary))),
    ]);
  }
}
