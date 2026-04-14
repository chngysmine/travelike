import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_search_bar.dart';
import '../../core/widgets/category_chips.dart';
import '../../core/widgets/premium_card.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/app_back_button.dart';
import '../../core/utils/app_animations.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedCategory = 0;
  bool _isUpcoming = true;

  List<Map<String, dynamic>> get _filteredEvents {
    if (_selectedCategory == 0) return MockData.events;
    return MockData.events.where((e) => e['category'] == MockData.eventCategories[_selectedCategory]).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leading: const Padding(
           padding: EdgeInsets.only(left: 10),
           child: AppBackButton(),
        ),
        title: Text('Events & Shows', style: AppTextStyles.displayMedium),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ==================== TOGGLE & SEARCH ====================
          Padding(
            padding: AppSpacing.screenH,
            child: Column(
              children: [
                AppSpacing.vMd,
                // Custom Toggle
                GlassContainer.solid(
                  height: 48,
                  borderRadius: 24,
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isUpcoming = true),
                          child: AnimatedContainer(
                            duration: AppAnimations.fast,
                            decoration: BoxDecoration(
                              color: _isUpcoming ? AppColors.primary : Colors.transparent,
                              borderRadius: AppSpacing.borderRound,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Upcoming',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: _isUpcoming ? Colors.white : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isUpcoming = false),
                          child: AnimatedContainer(
                            duration: AppAnimations.fast,
                            decoration: BoxDecoration(
                              color: !_isUpcoming ? AppColors.primary : Colors.transparent,
                              borderRadius: AppSpacing.borderRound,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Past Events',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: !_isUpcoming ? Colors.white : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.vLg,
                const AppSearchBar(
                  hintText: 'Search concerts, festivals...',
                  showFilter: true,
                ),
              ],
            ).fadeInUp(),
          ),

          AppSpacing.vLg,

          // ==================== CATEGORIES ====================
          CategoryChips(
            categories: MockData.eventCategories,
            selectedIndex: _selectedCategory,
            onSelected: (i) => setState(() => _selectedCategory = i),
            filled: false,
          ).fadeInUp(delay: 50.ms),

          AppSpacing.vLg,

          // ==================== EVENTS LIST ====================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              physics: const BouncingScrollPhysics(),
              itemCount: _filteredEvents.length,
              itemBuilder: (context, index) {
                final event = _filteredEvents[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: PremiumCard.event(
                    data: event,
                    onTap: () => Navigator.push(
                      context,
                      PageTransitions.slideUp(_EventDetailScreen(event: event)),
                    ),
                  ).fadeInScale(index: index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== EVENT DETAIL SCREEN ====================
class _EventDetailScreen extends StatelessWidget {
  final Map<String, dynamic> event;

  const _EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Hero Header
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
                 child: AppActionButton(icon: Icons.favorite_border_rounded, isOnImage: true, onTap: () {}),
               ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: event['image'],
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(gradient: AppColors.cardGradient),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Padding(
                  padding: AppSpacing.screenH,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSpacing.vXxl,
                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderSm),
                        child: Text(event['category'], style: AppTextStyles.labelMedium.primary),
                      ).fadeInUp(),
                      AppSpacing.vLg,
                      // Title
                      Text(event['title'] ?? event['name'] ?? 'Event', style: AppTextStyles.displayLarge).fadeInUp(delay: 50.ms),
                      AppSpacing.vXxl,
                      
                      // Info Grid
                      Row(
                        children: [
                          Expanded(
                            child: _InfoTile(icon: Iconsax.calendar_1, title: 'Date', subtitle: event['date']),
                          ),
                          Expanded(
                            child: _InfoTile(icon: Iconsax.clock, title: 'Time', subtitle: '19:00 - 22:30'),
                          ),
                        ],
                      ).fadeInUp(delay: 100.ms),
                      AppSpacing.vLg,
                      Row(
                        children: [
                          Expanded(
                            child: _InfoTile(icon: Iconsax.location, title: 'Location', subtitle: event['location']),
                          ),
                          Expanded(
                            child: _InfoTile(icon: Iconsax.ticket_2, title: 'Price', subtitle: '\$${event['price']}'),
                          ),
                        ],
                      ).fadeInUp(delay: 150.ms),
                      
                      AppSpacing.vXxl,
                      
                      // Attendees
                      Text('Going with', style: AppTextStyles.titleMedium).fadeInUp(delay: 200.ms),
                      AppSpacing.vLg,
                      SizedBox(
                        height: 48,
                        child: Stack(
                          children: [
                            ...List.generate(5, (index) {
                              return Positioned(
                                left: index * 36.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.backgroundLight, width: 3),
                                  ),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: CachedNetworkImageProvider(MockData.teamMembers[index]['avatar'] ?? ''),
                                  ),
                                ),
                              );
                            }),
                            Positioned(
                              left: 5 * 36.0,
                              child: Container(
                                width: 44, height: 44,
                                decoration: BoxDecoration(
                                  color: AppColors.primarySurface,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.backgroundLight, width: 3),
                                ),
                                alignment: Alignment.center,
                                child: Text('+24', style: AppTextStyles.labelMedium.primary),
                              ),
                            )
                          ],
                        ),
                      ).fadeInUp(delay: 250.ms),

                      AppSpacing.vXxl,
                      Text('About Event', style: AppTextStyles.titleMedium).fadeInUp(delay: 300.ms),
                      AppSpacing.vMd,
                      Text(
                        'Experience the magic of ${event['name']} live. This spectacular event brings together the best performers for an unforgettable night of entertainment and culture. Join thousands of fans in this historic celebration. Limited tickets available, book yours now to secure a spot!',
                        style: AppTextStyles.bodyLarge,
                      ).fadeInUp(delay: 350.ms),
                      
                      const SizedBox(height: 120), // Bottom padding
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // Booking Bottom Bar
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -4))],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Price', style: AppTextStyles.labelSmall),
                Text('\$${event['price']}', style: AppTextStyles.price),
              ],
            ),
            AppSpacing.hLg,
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Book Ticket Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderMd),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        AppSpacing.hMd,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.labelSmall),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.labelMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}
