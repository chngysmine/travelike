import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import '../gallery/photo_gallery_screen.dart';
import '../payment/payment_screen.dart';

class AttractionDetailScreen extends StatelessWidget {
  final Map<String, dynamic> destination;
  const AttractionDetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    final highlights = destination['highlights'] as List<String>? ?? ['Sightseeing', 'Photography'];
    final gallery = destination['gallery'] as List<String>? ?? [destination['image']];

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image
                GestureDetector(
                  onTap: () => Navigator.push(context, PageTransitions.fade(PhotoGalleryScreen(title: destination['name'], images: gallery))),
                  child: SizedBox(
                    height: 380,
                    width: double.infinity,
                    child: Stack(fit: StackFit.expand, children: [
                      Hero(tag: 'dest_${destination['name']}', child: CachedNetworkImage(imageUrl: destination['image'], fit: BoxFit.cover)),
                      const DecoratedBox(decoration: BoxDecoration(gradient: AppColors.cardGradient)),
                      Positioned(bottom: 24, left: 24, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                          child: Text('${gallery.length} photos', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white)),
                        ),
                      ])),
                    ]),
                  ),
                ),

                Container(
                  transform: Matrix4.translationValues(0, -28, 0),
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
                  padding: const EdgeInsets.all(24),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    // Title + Rating
                    Row(children: [
                      Expanded(child: Text(destination['name'], style: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.w700))),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(12)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.star_rounded, size: 18, color: AppColors.accentGold),
                          const SizedBox(width: 4),
                          Text('${destination['rating']}', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                          Text(' (${destination['reviews']})', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                        ]),
                      ),
                    ]).animate().fadeIn(duration: 400.ms),

                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Iconsax.location, size: 16, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(destination['location'], style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                    ]),

                    if (destination['bestTime'] != null) ...[
                      const SizedBox(height: 6),
                      Row(children: [
                        const Icon(Iconsax.calendar_1, size: 16, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text('Best time: ${destination['bestTime']}', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                      ]),
                    ],

                    const SizedBox(height: 20),

                    // Highlights
                    Text('Highlights', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8, runSpacing: 8,
                      children: highlights.map((h) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(12)),
                        child: Text(h, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primary)),
                      )).toList(),
                    ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

                    const SizedBox(height: 20),

                    // Description
                    Text('About', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(
                      destination['description'] ?? 'A beautiful destination in Vietnam worth visiting.',
                      style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary, height: 1.7),
                    ).animate().fadeIn(duration: 400.ms, delay: 200.ms),

                    const SizedBox(height: 20),

                    // Gallery
                    if (gallery.length > 1) ...[
                      Row(children: [
                        Text('Gallery', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.push(context, PageTransitions.fade(PhotoGalleryScreen(title: destination['name'], images: gallery))),
                          child: Text('See all', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
                        ),
                      ]),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: gallery.length,
                          itemBuilder: (_, i) => GestureDetector(
                            onTap: () => Navigator.push(context, PageTransitions.fade(PhotoGalleryScreen(title: destination['name'], images: gallery))),
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: ClipRRect(borderRadius: BorderRadius.circular(14), child: CachedNetworkImage(imageUrl: gallery[i], width: 100, height: 100, fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
                    ],

                    const SizedBox(height: 20),

                    // Tours
                    Text('Popular Tours', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    ...MockData.tours.take(2).map((tour) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(16)),
                      child: Row(children: [
                        ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(imageUrl: tour['image'], width: 70, height: 70, fit: BoxFit.cover)),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(tour['name'], maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text(tour['duration'], style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                          Text('\$${tour['price']}/person', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                        ])),
                      ]),
                    )),

                    const SizedBox(height: 100),
                  ]),
                ),
              ],
            ),
          ),

          // Top bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 8, left: 16, right: 16,
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.arrow_back_ios_new, size: 18))),
              const Spacer(),
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.favorite_border, size: 20, color: AppColors.primary)),
              const SizedBox(width: 8),
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Iconsax.share, size: 20)),
            ]),
          ),

          // CTA
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, -4))]),
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Price', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                  Text(destination['price'] == 0 ? 'Free Entry' : 'From \$${destination['price']}', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ]),
                const Spacer(),
                SizedBox(height: 52, child: ElevatedButton(
                  onPressed: () => Navigator.push(context, PageTransitions.slideUp(const PaymentScreen())),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), padding: const EdgeInsets.symmetric(horizontal: 32)),
                  child: Text('Book Now', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
