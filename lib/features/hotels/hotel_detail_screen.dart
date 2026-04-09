import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../payment/payment_screen.dart';

class HotelDetailScreen extends StatefulWidget {
  final Map<String, dynamic> hotel;
  const HotelDetailScreen({super.key, required this.hotel});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  int _selectedImage = 0;
  int _selectedRoom = 0;

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;
    final gallery = hotel['gallery'] as List<String>;
    final rooms = hotel['rooms'] as List<Map<String, dynamic>>;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image gallery
                SizedBox(
                  height: 300,
                  child: PageView.builder(
                    itemCount: gallery.length,
                    onPageChanged: (i) => setState(() => _selectedImage = i),
                    itemBuilder: (_, i) => CachedNetworkImage(imageUrl: gallery[i], fit: BoxFit.cover, width: double.infinity),
                  ),
                ),
                // Dots
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(gallery.length, (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: _selectedImage == i ? 24 : 8, height: 8,
                        decoration: BoxDecoration(color: _selectedImage == i ? AppColors.primary : Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(hotel['name'], style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700))),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(10)),
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              const Icon(Icons.star_rounded, size: 16, color: AppColors.accentGold),
                              const SizedBox(width: 4),
                              Text('${hotel['rating']}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
                            ]),
                          ),
                        ],
                      ).animate().fadeIn(duration: 400.ms),
                      const SizedBox(height: 6),
                      Row(children: [
                        const Icon(Iconsax.location, size: 16, color: AppColors.textTertiary),
                        const SizedBox(width: 4),
                        Text(hotel['location'], style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                      ]),
                      const SizedBox(height: 16),
                      // Amenities
                      Text('Amenities', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8, runSpacing: 8,
                        children: (hotel['amenities'] as List<String>).map((a) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                          child: Text(a, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                        )).toList(),
                      ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
                      const SizedBox(height: 20),
                      Text('About', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Text(hotel['description'], style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary, height: 1.6)),
                      const SizedBox(height: 24),
                      // Rooms
                      Text('Available Rooms', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 12),
                      ...rooms.asMap().entries.map((entry) {
                        final i = entry.key;
                        final room = entry.value;
                        final isSelected = _selectedRoom == i;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedRoom = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade200, width: isSelected ? 2 : 1),
                              boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 12)] : null,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(imageUrl: room['image'], width: 80, height: 80, fit: BoxFit.cover)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(room['name'], style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 4),
                                      Text('${room['size']} · ${room['bed']} Bed · ${room['view']} View', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                                      const SizedBox(height: 6),
                                      Text('\$${room['price']}/night', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary)),
                                    ],
                                  ),
                                ),
                                if (isSelected) const Icon(Icons.check_circle, color: AppColors.primary),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(duration: 400.ms, delay: (200 + i * 80).ms);
                      }),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Top bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 8, left: 16, right: 16,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.arrow_back_ios_new, size: 18)),
                ),
                const Spacer(),
                Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.favorite_border, size: 20, color: AppColors.primary)),
                const SizedBox(width: 8),
                Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Iconsax.share, size: 20)),
              ],
            ),
          ),
          // Bottom CTA
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, -4))]),
              child: Row(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Total Price', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                    Text('\$${rooms[_selectedRoom]['price']}/night', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  ]),
                  const Spacer(),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, PageTransitions.slideUp(const PaymentScreen())),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), padding: const EdgeInsets.symmetric(horizontal: 32)),
                      child: Text('Book Now', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
