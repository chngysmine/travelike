import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import '../events/events_screen.dart';
import '../food/local_dishup_screen.dart';
import '../blog/blog_list_screen.dart';
import '../attractions/attraction_detail_screen.dart';
import '../flights/book_flight_screen.dart';
import '../social/message_screen.dart';
import '../hotels/hotel_list_screen.dart';
import '../tours/tour_list_screen.dart';
import '../currency/currency_screen.dart';
import '../search/search_screen.dart';
import '../notifications/notification_screen.dart';
import '../region/region_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildHeader().animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 20),
              _buildSearchBar().animate().fadeIn(duration: 400.ms, delay: 100.ms),
              const SizedBox(height: 20),
              _buildCategories().animate().fadeIn(duration: 400.ms, delay: 200.ms),
              const SizedBox(height: 24),
              _buildSectionHeader('Your Location', 'See all', () => Navigator.push(context, PageTransitions.slideRight(const RegionScreen()))),
              const SizedBox(height: 16),
              _buildLocationCarousel().animate().fadeIn(duration: 500.ms, delay: 300.ms),
              const SizedBox(height: 28),
              _buildSectionHeader('Quick Access', '', () {}),
              const SizedBox(height: 16),
              _buildQuickAccessGrid().animate().fadeIn(duration: 500.ms, delay: 400.ms),
              const SizedBox(height: 28),
              _buildSectionHeader('Popular Destinations', 'See all', () => Navigator.push(context, PageTransitions.slideRight(const RegionScreen()))),
              const SizedBox(height: 16),
              _buildDestinationsList().animate().fadeIn(duration: 500.ms, delay: 500.ms),
              const SizedBox(height: 28),
              _buildSectionHeader('Upcoming Events', 'See all', () => Navigator.push(context, PageTransitions.slideRight(const EventsScreen()))),
              const SizedBox(height: 16),
              _buildEventsPreview().animate().fadeIn(duration: 500.ms, delay: 600.ms),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text('Current Location', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textTertiary),
              ]),
              const SizedBox(height: 4),
              Text('Hoi An, Da Nang', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, PageTransitions.slideRight(const NotificationScreen())),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
            ),
            child: Stack(children: [
              const Icon(Iconsax.notification, size: 22, color: AppColors.textPrimary),
              Positioned(top: 0, right: 0, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
            ]),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 44, height: 44,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.primary, width: 2)),
            child: ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(imageUrl: MockData.userAvatar, fit: BoxFit.cover)),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () => Navigator.push(context, PageTransitions.fade(const SearchScreen())),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            const Icon(Iconsax.search_normal, size: 20, color: AppColors.textTertiary),
            const SizedBox(width: 12),
            Expanded(child: Text('Search destinations, food, events...', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textTertiary))),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Iconsax.microphone_2, size: 18, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: MockData.homeCategories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade300),
                boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))] : null,
              ),
              child: Text(MockData.homeCategories[index], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.textSecondary)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        if (action.isNotEmpty) TextButton(onPressed: onTap, child: Text(action, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary))),
      ],
    );
  }

  Widget _buildLocationCarousel() {
    final locations = [
      {'name': 'Da Nang', 'image': MockData.imgDaNang, 'subtitle': '🌉 Dragon Bridge City'},
      {'name': 'Hoi An', 'image': MockData.imgHoiAn, 'subtitle': '🏮 Ancient Town'},
      {'name': 'Hue', 'image': MockData.imgHue, 'subtitle': '🏛️ Imperial Citadel'},
      {'name': 'Sa Pa', 'image': MockData.imgSaPa, 'subtitle': '🌾 Rice Terraces'},
    ];

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final loc = locations[index];
          return GestureDetector(
            onTap: () {
              final dest = MockData.destinations.firstWhere((d) => (d['name'] as String).contains(loc['name']!.split(',')[0]), orElse: () => MockData.destinations[0]);
              Navigator.push(context, PageTransitions.fadeScale(AttractionDetailScreen(destination: dest)));
            },
            child: Container(
              width: 260, margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 12, offset: const Offset(0, 6))]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(fit: StackFit.expand, children: [
                  CachedNetworkImage(imageUrl: loc['image']!, fit: BoxFit.cover),
                  const DecoratedBox(decoration: BoxDecoration(gradient: AppColors.cardGradient)),
                  Positioned(
                    bottom: 16, left: 16,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(loc['name']!, style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(loc['subtitle']!, style: GoogleFonts.inter(fontSize: 12, color: Colors.white70)),
                    ]),
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickAccessGrid() {
    final items = [
      {'icon': Iconsax.reserve, 'label': 'Local\nDishup', 'color': AppColors.categoryFood, 'screen': 'food'},
      {'icon': Iconsax.edit, 'label': 'New\nPosts', 'color': AppColors.categoryBeach, 'screen': 'blog'},
      {'icon': Iconsax.calendar_1, 'label': 'Events', 'color': AppColors.categoryCulture, 'screen': 'events'},
      {'icon': Iconsax.building_4, 'label': 'Hotels', 'color': AppColors.categoryMountain, 'screen': 'hotels'},
      {'icon': Iconsax.airplane, 'label': 'Flights', 'color': AppColors.categoryNightlife, 'screen': 'flights'},
      {'icon': Iconsax.message, 'label': 'Messages', 'color': AppColors.accentTeal, 'screen': 'messages'},
      {'icon': Iconsax.map_1, 'label': 'Tours', 'color': AppColors.chipBlue, 'screen': 'tours'},
      {'icon': Iconsax.dollar_circle, 'label': 'Currency', 'color': AppColors.chipGreen, 'screen': 'currency'},
      {'icon': Iconsax.global, 'label': 'Regions', 'color': AppColors.chipPurple, 'screen': 'regions'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.1, crossAxisSpacing: 12, mainAxisSpacing: 12),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            Widget? screen;
            switch (item['screen']) {
              case 'food': screen = const LocalDishupScreen(); break;
              case 'blog': screen = const BlogListScreen(); break;
              case 'events': screen = const EventsScreen(); break;
              case 'flights': screen = const BookFlightScreen(); break;
              case 'messages': screen = const MessageScreen(); break;
              case 'hotels': screen = const HotelListScreen(); break;
              case 'tours': screen = const TourListScreen(); break;
              case 'currency': screen = const CurrencyScreen(); break;
              case 'regions': screen = const RegionScreen(); break;
            }
            if (screen != null) Navigator.push(context, PageTransitions.slideRight(screen));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: (item['color'] as Color).withValues(alpha: 0.15), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: (item['color'] as Color).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(14)),
                child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 24),
              ),
              const SizedBox(height: 8),
              Text(item['label'] as String, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.2)),
            ]),
          ),
        );
      },
    );
  }

  Widget _buildDestinationsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        final dest = MockData.destinations[index];
        return GestureDetector(
          onTap: () => Navigator.push(context, PageTransitions.fadeScale(AttractionDetailScreen(destination: dest))),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16), height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 6))]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(fit: StackFit.expand, children: [
                CachedNetworkImage(imageUrl: dest['image'], fit: BoxFit.cover),
                const DecoratedBox(decoration: BoxDecoration(gradient: AppColors.cardGradient)),
                Positioned(
                  top: 16, left: 16,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(dest['name'], style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
                    Text(dest['location'], style: GoogleFonts.inter(fontSize: 13, color: Colors.white70)),
                  ]),
                ),
                Positioned(
                  top: 16, right: 16,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Iconsax.archive_add, color: Colors.white, size: 20)),
                  ),
                ),
                Positioned(
                  bottom: 16, right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.star_rounded, color: AppColors.accentGold, size: 16),
                      const SizedBox(width: 4),
                      Text('${dest['rating']}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                    ]),
                  ),
                ),
                Positioned(
                  bottom: 16, left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.85), borderRadius: BorderRadius.circular(8)),
                    child: Text(dest['price'] == 0 ? 'Free' : 'From \$${dest['price']}', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventsPreview() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          final event = MockData.events[index];
          return GestureDetector(
            onTap: () => Navigator.push(context, PageTransitions.slideRight(const EventsScreen())),
            child: Container(
              width: 280, margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))]),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Stack(children: [
                  ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), child: CachedNetworkImage(imageUrl: event['image'], height: 120, width: double.infinity, fit: BoxFit.cover)),
                  Positioned(top: 10, left: 10, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)), child: Text(event['category'] ?? '', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white)))),
                ]),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(event['date'], style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    const SizedBox(height: 4),
                    Text(event['title'], maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Icon(Iconsax.location, size: 14, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Expanded(child: Text(event['location'], maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary))),
                    ]),
                  ]),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
