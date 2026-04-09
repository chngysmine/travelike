import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import 'hotel_detail_screen.dart';

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({super.key});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  int _selectedCategory = 0;

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
                    Text('Hotels & Stays', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)]),
                      child: const Icon(Iconsax.filter, size: 20, color: AppColors.primary),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),
              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)]),
                  child: Row(
                    children: [
                      const Icon(Iconsax.search_normal, size: 20, color: AppColors.textTertiary),
                      const SizedBox(width: 12),
                      Expanded(child: TextField(decoration: InputDecoration(hintText: 'Search hotels, resorts...', hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.textTertiary), border: InputBorder.none, enabledBorder: InputBorder.none, focusedBorder: InputBorder.none))),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
              const SizedBox(height: 16),
              // Categories
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: MockData.hotelCategories.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategory == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(color: isSelected ? AppColors.primary : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade300)),
                        child: Center(child: Text(MockData.hotelCategories[index], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.textSecondary))),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: MockData.hotels.length,
                  itemBuilder: (context, index) {
                    final hotel = MockData.hotels[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, PageTransitions.fadeScale(HotelDetailScreen(hotel: hotel))),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), child: CachedNetworkImage(imageUrl: hotel['image'], height: 175, width: double.infinity, fit: BoxFit.cover)),
                                Positioned(top: 12, right: 12, child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.favorite_border_rounded, size: 20, color: AppColors.primary))),
                                Positioned(bottom: 12, left: 12, child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)), child: Text('From \$${hotel['pricePerNight']}/night', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)))),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(hotel['name'], style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 4),
                                  Row(children: [
                                    const Icon(Iconsax.location, size: 14, color: AppColors.textTertiary),
                                    const SizedBox(width: 4),
                                    Expanded(child: Text(hotel['location'], style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary))),
                                    const Icon(Icons.star_rounded, size: 16, color: AppColors.accentGold),
                                    const SizedBox(width: 4),
                                    Text('${hotel['rating']}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                                    Text(' (${hotel['reviews']})', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textTertiary)),
                                  ]),
                                  const SizedBox(height: 8),
                                  Wrap(spacing: 6, children: (hotel['amenities'] as List<String>).take(4).map((a) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(6)), child: Text(a, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.primary)))).toList()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: (index * 80).ms).slideY(begin: 0.05, end: 0);
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
