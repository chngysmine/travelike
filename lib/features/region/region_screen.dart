import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../core/utils/page_transitions.dart';
import '../attractions/attraction_detail_screen.dart';

class RegionScreen extends StatelessWidget {
  const RegionScreen({super.key});

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
                    Text('Explore Regions', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Discover Vietnam\'s unique regions', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.85, crossAxisSpacing: 12, mainAxisSpacing: 12),
                  itemCount: MockData.regions.length,
                  itemBuilder: (context, index) {
                    final region = MockData.regions[index];
                    return GestureDetector(
                      onTap: () {
                        final dest = MockData.destinations.firstWhere((d) => (d['location'] as String).contains(region['name']!.split(',')[0]), orElse: () => MockData.destinations[0]);
                        Navigator.push(context, PageTransitions.fadeScale(AttractionDetailScreen(destination: dest)));
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 12, offset: const Offset(0, 4))]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(fit: StackFit.expand, children: [
                            CachedNetworkImage(imageUrl: region['image']!, fit: BoxFit.cover),
                            Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)]))),
                            Positioned(
                              bottom: 16, left: 16,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(region['name']!, style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                                Text('🇻🇳 Vietnam', style: GoogleFonts.inter(fontSize: 11, color: Colors.white70)),
                              ]),
                            ),
                          ]),
                        ),
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: (index * 60).ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1.0, 1.0));
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
