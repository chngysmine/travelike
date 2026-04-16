import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_search_bar.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/category_chips.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/utils/app_animations.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import '../super_app_hub_screen.dart';
import '../events/events_screen.dart';
import '../food/local_dishup_screen.dart';
import '../flights/book_flight_screen.dart';
import '../hotels/hotel_list_screen.dart';
import '../tours/tour_list_screen.dart';
import '../currency/currency_screen.dart';
import '../blog/blog_list_screen.dart';
import '../region/region_screen.dart';
import '../search/search_screen.dart';
import '../social/message_screen.dart';
import '../notifications/notification_screen.dart';
import '../attractions/attraction_detail_screen.dart';

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
      bottom: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== HEADER ====================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, ${MockData.userName} 👋',
                          style: AppTextStyles.displayMedium,
                        ),
                        AppSpacing.vXs,
                        Text(
                          'Where do you want to go?',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  // Message icon
                  GestureDetector(
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const MessageScreen())),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppSpacing.borderMd,
                        boxShadow: AppSpacing.shadowSm,
                      ),
                      child: const Center(child: Icon(Iconsax.message, size: 22, color: AppColors.textPrimary)),
                    ),
                  ),
                  AppSpacing.hSm,
                  // Notification bell
                  GestureDetector(
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const NotificationScreen())),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: AppSpacing.borderMd,
                        boxShadow: AppSpacing.shadowSm,
                      ),
                      child: Stack(
                        children: [
                          const Center(child: Icon(Iconsax.notification, size: 22, color: AppColors.textPrimary)),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.accentRed,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.hSm,
                  // Avatar
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: AppSpacing.borderMd,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: MockData.userAvatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ).fadeInUp(),

            // (Banner removed from here and moved to Quick Access section)

            // ==================== SEARCH BAR ====================
            Padding(
              padding: AppSpacing.screenH,
              child: AppSearchBar(
                hintText: 'Search destinations, food, events...',
                showFilter: true,
                onTap: () => Navigator.push(context, PageTransitions.fadeScale(const SearchScreen())),
                onFilterTap: () => Navigator.push(context, PageTransitions.slideRight(const RegionScreen())),
              ),
            ).fadeInUp(index: 1),

            AppSpacing.vXxl,

            // ==================== QUICK ACCESS GRID ====================
            SectionHeader(
              title: 'Quick Access',
              padding: AppSpacing.screenH,
            ).fadeInUp(index: 2),

            AppSpacing.vMd,

            // ==================== EXPLORE ALL BANNER ====================
            const _AnimatedExploreBanner().fadeInUp(index: 2),

            AppSpacing.vLg,

            Padding(
              padding: AppSpacing.screenH,
              child: Row(
                children: [
                  _QuickAccessItem(
                    icon: Iconsax.airplane,
                    label: 'Flights',
                    color: const Color(0xFF3B82F6),
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const BookFlightScreen())),
                  ),
                  AppSpacing.hMd,
                  _QuickAccessItem(
                    icon: Iconsax.building,
                    label: 'Hotels',
                    color: const Color(0xFF8B5CF6),
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const HotelListScreen())),
                  ),
                  AppSpacing.hMd,
                  _QuickAccessItem(
                    icon: Iconsax.map_1,
                    label: 'Tours',
                    color: const Color(0xFF10B981),
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const TourListScreen())),
                  ),
                  AppSpacing.hMd,
                  _QuickAccessItem(
                    icon: Iconsax.calendar_tick,
                    label: 'Events',
                    color: const Color(0xFFF97316),
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const EventsScreen())),
                  ),
                ],
              ),
            ).fadeInUp(index: 3),

            AppSpacing.vSm,

            Padding(
              padding: AppSpacing.screenH,
              child: Row(
                children: [
                  _QuickAccessItem(
                    icon: Iconsax.reserve,
                    label: 'Food',
                    color: const Color(0xFFEF4444),
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const LocalDishupScreen())),
                  ),
                  AppSpacing.hMd,
                  _QuickAccessItem(
                    icon: Iconsax.dollar_circle,
                    label: 'Currency',
                    color: const Color(0xFFD4A853),
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const CurrencyScreen())),
                  ),
                  AppSpacing.hMd,
                  _QuickAccessItem(
                    icon: Iconsax.global,
                    label: 'Regions',
                    color: const Color(0xFF14B8A6),
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const RegionScreen())),
                  ),
                  AppSpacing.hMd,
                  _QuickAccessItem(
                    icon: Iconsax.document_text,
                    label: 'Blog',
                    color: const Color(0xFFEC4899),
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const BlogListScreen())),
                  ),
                ],
              ),
            ).fadeInUp(index: 5),

            AppSpacing.vXxl,

            // ==================== CATEGORIES ====================
            CategoryChips(
              categories: MockData.homeCategories,
              selectedIndex: _selectedCategory,
              onSelected: (i) => setState(() => _selectedCategory = i),
            ).fadeInUp(index: 5),

            AppSpacing.vLg,

            // ==================== POPULAR DESTINATIONS ====================
            SectionHeader(
              title: 'Popular Destinations',
              actionText: 'See all',
              actionIcon: Icons.arrow_forward_ios_rounded,
              padding: AppSpacing.screenH,
              onActionTap: () {},
            ).fadeInUp(index: 6),

            AppSpacing.vMd,

            SizedBox(
              height: 260,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: AppSpacing.screenH,
                physics: const BouncingScrollPhysics(),
                itemCount: MockData.destinations.length,
                itemBuilder: (context, index) {
                  final dest = MockData.destinations[index];
                  return _DestinationCard(
                    destination: dest,
                    onTap: () => Navigator.push(
                      context,
                      PageTransitions.fadeScale(AttractionDetailScreen(destination: dest)),
                    ),
                  ).fadeInScale(index: index);
                },
              ),
            ),

            AppSpacing.vXxl,

            // ==================== TRENDING TOURS ====================
            SectionHeader(
              title: 'Trending Tours',
              actionText: 'See all',
              actionIcon: Icons.arrow_forward_ios_rounded,
              padding: AppSpacing.screenH,
              onActionTap: () => Navigator.push(context, PageTransitions.slideRight(const TourListScreen())),
            ).fadeInUp(index: 7),

            AppSpacing.vMd,

            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: AppSpacing.screenH,
                physics: const BouncingScrollPhysics(),
                itemCount: MockData.tours.length,
                itemBuilder: (context, index) {
                  final tour = MockData.tours[index];
                  return _TourCard(tour: tour).fadeInLeft(index: index);
                },
              ),
            ),

            AppSpacing.vXxl,

            // ==================== FEATURED BLOG POSTS ====================
            SectionHeader(
              title: 'Travel Stories',
              actionText: 'See all',
              actionIcon: Icons.arrow_forward_ios_rounded,
              padding: AppSpacing.screenH,
              onActionTap: () => Navigator.push(context, PageTransitions.slideRight(const BlogListScreen())),
            ).fadeInUp(index: 8),

            AppSpacing.vMd,

            ...MockData.blogPosts.take(3).toList().asMap().entries.map((entry) {
              return _BlogCard(
                post: entry.value,
                index: entry.key,
              );
            }),

            // Bottom safe space for nav bar
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

// ==================== QUICK ACCESS GRID ITEM ====================
class _QuickAccessItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAccessItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: AppSpacing.borderLg,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            AppSpacing.vSm,
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== DESTINATION CARD ====================
class _DestinationCard extends StatelessWidget {
  final Map<String, dynamic> destination;
  final VoidCallback onTap;

  const _DestinationCard({
    required this.destination,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: AppSpacing.borderXl,
          boxShadow: AppColors.cardShadow,
        ),
        child: ClipRRect(
          borderRadius: AppSpacing.borderXl,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: destination['image'],
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: AppColors.primarySurface,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(gradient: AppColors.cardGradient),
              ),
              // Rating badge
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: AppSpacing.borderSm,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.accentGold, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        '${destination['rating']}',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Price badge
              if (destination['price'] != null && destination['price'] > 0)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.85),
                      borderRadius: AppSpacing.borderSm,
                    ),
                    child: Text(
                      '\$${destination['price']}',
                      style: AppTextStyles.badge,
                    ),
                  ),
                ),
              // Bottom info
              Positioned(
                bottom: 16,
                left: 14,
                right: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination['name'],
                      style: AppTextStyles.titleMedium.white,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Iconsax.location, size: 12, color: Colors.white70),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            destination['location'],
                            style: AppTextStyles.labelSmall.white70,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== TOUR CARD ====================
class _TourCard extends StatelessWidget {
  final Map<String, dynamic> tour;

  const _TourCard({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppSpacing.borderXl,
        boxShadow: AppSpacing.shadowMd,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
            child: CachedNetworkImage(
              imageUrl: tour['image'],
              width: 120,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                width: 120,
                color: AppColors.primarySurface,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius: AppSpacing.borderSm,
                    ),
                    child: Text(
                      tour['duration'],
                      style: AppTextStyles.badge.primary,
                    ),
                  ),
                  AppSpacing.vSm,
                  Text(
                    tour['name'],
                    style: AppTextStyles.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 14, color: AppColors.accentGold),
                      const SizedBox(width: 2),
                      Text('${tour['rating']}', style: AppTextStyles.rating.copyWith(fontSize: 12)),
                      Text(
                        ' (${tour['reviews']})',
                        style: AppTextStyles.labelSmall,
                      ),
                      const Spacer(),
                      Text(
                        '\$${tour['price']}',
                        style: AppTextStyles.titleMedium.primary,
                      ),
                    ],
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

// ==================== BLOG CARD ====================
class _BlogCard extends StatelessWidget {
  final Map<String, dynamic> post;
  final int index;

  const _BlogCard({required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: GlassContainer.solid(
        borderRadius: 20,
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: AppSpacing.borderMd,
              child: CachedNetworkImage(
                imageUrl: post['image'],
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  width: 90,
                  height: 90,
                  color: AppColors.primarySurface,
                ),
              ),
            ),
            AppSpacing.hMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title'],
                    style: AppTextStyles.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.vSm,
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: CachedNetworkImageProvider(post['authorAvatar']),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          post['author'],
                          style: AppTextStyles.labelSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      Text(post['date'], style: AppTextStyles.labelSmall),
                    ],
                  ),
                  AppSpacing.vSm,
                  Row(
                    children: [
                      const Icon(Iconsax.heart, size: 14, color: AppColors.chipRed),
                      const SizedBox(width: 4),
                      Text('${post['likes']}', style: AppTextStyles.labelSmall),
                      AppSpacing.hMd,
                      const Icon(Iconsax.message, size: 14, color: AppColors.textTertiary),
                      const SizedBox(width: 4),
                      Text('${post['comments']}', style: AppTextStyles.labelSmall),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).fadeInUp(index: index + 9);
  }
}

// ==================== ANIMATED EXPLORE BANNER ====================
class _AnimatedExploreBanner extends StatefulWidget {
  const _AnimatedExploreBanner();

  @override
  State<_AnimatedExploreBanner> createState() => _AnimatedExploreBannerState();
}

class _AnimatedExploreBannerState extends State<_AnimatedExploreBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SuperAppHubScreen())),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF1E293B), // Premium dark border slate
                  Color.lerp(const Color(0xFF1E293B), const Color(0xFF38BDF8), _controller.value * 0.2)!, // Breathing neon blue accent
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color.lerp(Colors.white10, const Color(0xFF38BDF8).withValues(alpha: 0.6), _controller.value)!,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF38BDF8).withValues(alpha: 0.15 * _controller.value),
                  blurRadius: 20 * _controller.value,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF38BDF8).withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Iconsax.category_2, color: Color(0xFF7DD3FC), size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Explore 50+ Top Features",
                        style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Open Super App Hub • AI, AR & More",
                        style: AppTextStyles.labelSmall.copyWith(color: const Color(0xFF94A3B8)),
                      ),
                    ],
                  ),
                ),
                Container(
                   padding: const EdgeInsets.all(8),
                   decoration: BoxDecoration(
                     color: Colors.white.withValues(alpha: 0.1), 
                     shape: BoxShape.circle
                   ),
                   child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 14),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
