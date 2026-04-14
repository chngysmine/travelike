import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_back_button.dart';
import '../../core/widgets/section_header.dart';
import '../../core/utils/app_animations.dart';
import '../../core/utils/page_transitions.dart';
import '../payment/payment_screen.dart';

class TourDetailScreen extends StatelessWidget {
  final Map<String, dynamic> tour;

  const TourDetailScreen({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ==================== PARALLAX HEADER ====================
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10, top: 4),
              child: AppBackButton.onImage(),
            ),
            actions: [
               Padding(
                padding: const EdgeInsets.only(right: 16, top: 4),
                child: AppActionButton(icon: Iconsax.heart, isOnImage: true, onTap: () {}),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'tour_${tour['name']}',
                    child: CachedNetworkImage(
                      imageUrl: tour['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==================== CONTENT ====================
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: AppSpacing.screenH,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacing.vLg,
                    // Title & Rating
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            tour['name'],
                            style: AppTextStyles.displayMedium,
                          ).fadeInUp(),
                        ),
                        AppSpacing.hSm,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            borderRadius: AppSpacing.borderRound,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Colors.orange, size: 18),
                              AppSpacing.hXs,
                              Text(tour['rating'].toString(), style: AppTextStyles.labelLarge),
                            ],
                          ),
                        ).fadeInScale(),
                      ],
                    ),
                    AppSpacing.vXs,
                    Text('Duration: ${tour['duration']} • ${tour['reviews']} reviews', style: AppTextStyles.titleMedium.secondary).fadeInUp(delay: 50.ms),
                    
                    AppSpacing.vXxl,

                    // Overview
                    SectionHeader(title: 'Overview').fadeInUp(delay: 100.ms),
                    AppSpacing.vMd,
                    Text(
                      'Experience an unforgettable journey through breathtaking landscapes. This tour captures the essence of local culture, food, and stunning natural wonders making it a perfect getaway.',
                      style: AppTextStyles.bodyLarge.secondary,
                    ).fadeInUp(delay: 150.ms),

                    AppSpacing.vXxl,

                    // Itinerary
                    SectionHeader(title: 'Itinerary').fadeInUp(delay: 200.ms),
                    AppSpacing.vLg,
                    _buildItineraryDay(1, 'Arrival & Welcome Dinner').fadeInUp(delay: 250.ms),
                    AppSpacing.vLg,
                    _buildItineraryDay(2, 'Exploration & Sightseeing').fadeInUp(delay: 300.ms),
                    AppSpacing.vLg,
                    _buildItineraryDay(3, 'Local Culture & Departure').fadeInUp(delay: 350.ms),

                    AppSpacing.vXxl,
                    AppSpacing.vXxl,
                    AppSpacing.vXxl, // Padding for bottom bar
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomBar(context),
    );
  }

  Widget _buildItineraryDay(int day, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text('D$day', style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary)),
          ),
        ),
        AppSpacing.hLg,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.titleLarge),
              AppSpacing.vXs,
              Text('Detailed schedule and activities for Day $day. Start at 8:00 AM.', style: AppTextStyles.bodyMedium.secondary),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Price', style: AppTextStyles.labelMedium.secondary),
                Text(
                  '\$${tour['price']}',
                  style: AppTextStyles.hero.copyWith(fontSize: 28, color: AppColors.primary),
                ),
              ],
            ),
            AppSpacing.hLg,
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, PageTransitions.slideUp(const PaymentScreen())),
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
