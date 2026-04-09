import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import '../attractions/attraction_detail_screen.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  int _selectedChip = 0;
  final _categories = ['All', 'Destinations', 'Food', 'Hotels', 'Tours'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Hi, ${MockData.userName} 👋', style: GoogleFonts.playfairDisplay(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text('Your saved collection', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                ]),
                const Spacer(),
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.primary, width: 2)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(imageUrl: MockData.userAvatar, fit: BoxFit.cover)),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)]),
              child: Row(children: [
                const Icon(Iconsax.search_normal, size: 20, color: AppColors.textTertiary),
                const SizedBox(width: 12),
                Text('Search your saved items...', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textTertiary)),
                const Spacer(),
                const Icon(Iconsax.microphone_2, size: 20, color: AppColors.textTertiary),
              ]),
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

          const SizedBox(height: 16),

          // Chips
          SizedBox(
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              itemBuilder: (_, index) {
                final isSelected = _selectedChip == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedChip = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade300),
                      boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))] : null,
                    ),
                    child: Center(child: Text(_categories[index], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.textSecondary))),
                  ),
                );
              },
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 200.ms),

          const SizedBox(height: 16),

          // Stats bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              Text('${MockData.destinations.length} items saved', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textTertiary)),
              const Spacer(),
              Icon(Iconsax.element_4, size: 18, color: AppColors.textTertiary),
              const SizedBox(width: 12),
              Icon(Iconsax.menu, size: 18, color: AppColors.primary),
            ]),
          ),

          const SizedBox(height: 12),

          // Destinations List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: MockData.destinations.length,
              itemBuilder: (context, index) {
                final dest = MockData.destinations[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, PageTransitions.fadeScale(AttractionDetailScreen(destination: dest))),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 200,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 6))]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(fit: StackFit.expand, children: [
                        CachedNetworkImage(imageUrl: dest['image'], fit: BoxFit.cover),
                        const DecoratedBox(decoration: BoxDecoration(gradient: AppColors.cardGradient)),
                        Positioned(
                          bottom: 16, left: 16, right: 16,
                          child: Row(children: [
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(dest['name'], style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                              Row(children: [
                                const Icon(Iconsax.location, size: 14, color: Colors.white70),
                                const SizedBox(width: 4),
                                Text(dest['location'], style: GoogleFonts.inter(fontSize: 13, color: Colors.white70)),
                              ]),
                            ])),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                              child: Row(mainAxisSize: MainAxisSize.min, children: [
                                const Icon(Icons.star_rounded, color: AppColors.accentGold, size: 16),
                                const SizedBox(width: 4),
                                Text('${dest['rating']}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                              ]),
                            ),
                          ]),
                        ),
                        Positioned(
                          top: 16, right: 16,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.bookmark_rounded, color: Colors.white, size: 20),
                          ),
                        ),
                        Positioned(
                          top: 16, left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)),
                            child: Text(dest['price'] == 0 ? 'Free' : 'From \$${dest['price']}', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: (100 + index * 80).ms).slideY(begin: 0.03, end: 0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
