import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';

class TourListScreen extends StatelessWidget {
  const TourListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20)),
                    const SizedBox(width: 12),
                    Text('Tours & Packages', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: MockData.tours.length,
                  itemBuilder: (context, index) {
                    final tour = MockData.tours[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, PageTransitions.fadeScale(TourDetailScreen(tour: tour))),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(children: [
                              ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), child: CachedNetworkImage(imageUrl: tour['image'], height: 160, width: double.infinity, fit: BoxFit.cover)),
                              Positioned(top: 12, left: 12, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)), child: Text(tour['duration'], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)))),
                              Positioned(top: 12, right: 12, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)), child: Text('\$${tour['price']}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)))),
                            ]),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(tour['name'], style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 6),
                                Row(children: [
                                  const Icon(Icons.star_rounded, size: 14, color: AppColors.accentGold),
                                  const SizedBox(width: 4),
                                  Text('${tour['rating']}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                                  Text(' (${tour['reviews']} reviews)', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                                ]),
                                const SizedBox(height: 8),
                                Wrap(spacing: 6, children: (tour['includes'] as List<String>).map((inc) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(6)), child: Text(inc, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.primary)))).toList()),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: (index * 100).ms).slideY(begin: 0.05, end: 0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TourDetailScreen extends StatelessWidget {
  final Map<String, dynamic> tour;
  const TourDetailScreen({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 320, width: double.infinity, child: CachedNetworkImage(imageUrl: tour['image'], fit: BoxFit.cover)),
              Container(
                transform: Matrix4.translationValues(0, -28, 0),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
                padding: const EdgeInsets.all(24),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.chipGreen, borderRadius: BorderRadius.circular(8)), child: Text(tour['duration'], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white))),
                    const Spacer(),
                    const Icon(Icons.star_rounded, size: 18, color: AppColors.accentGold),
                    Text(' ${tour['rating']}', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                    Text(' (${tour['reviews']})', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                  ]),
                  const SizedBox(height: 16),
                  Text(tour['name'], style: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  Text('What\'s Included', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  Wrap(spacing: 8, runSpacing: 8, children: (tour['includes'] as List<String>).map((inc) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(12)), child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.check_circle, size: 16, color: AppColors.chipGreen), const SizedBox(width: 6), Text(inc, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500))]))).toList()),
                  const SizedBox(height: 20),
                  Text('Description', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(tour['description'], style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary, height: 1.7)),
                  const SizedBox(height: 100),
                ]),
              ),
            ]),
          ),
          Positioned(top: MediaQuery.of(context).padding.top + 8, left: 16, child: GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.arrow_back_ios_new, size: 18)))),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, -4))]),
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('From', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                  Text('\$${tour['price']}/person', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ]),
                const Spacer(),
                SizedBox(height: 52, child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), padding: const EdgeInsets.symmetric(horizontal: 32)), child: Text('Book Tour', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)))),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
