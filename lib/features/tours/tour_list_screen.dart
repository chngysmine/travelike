import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_search_bar.dart';
import '../../core/widgets/category_chips.dart';
import '../../core/widgets/premium_card.dart';
import '../../core/widgets/app_back_button.dart';
import '../../core/utils/app_animations.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import '../search/search_screen.dart';
import '../map/map_screen.dart';
import 'tour_detail_screen.dart';

class TourListScreen extends StatefulWidget {
  const TourListScreen({super.key});

  @override
  State<TourListScreen> createState() => _TourListScreenState();
}

class _TourListScreenState extends State<TourListScreen> {
  int _selectedDuration = 0;
  final List<String> _durations = ['All', '1-2 Days', '3-5 Days', '1 Week+'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leading: const Padding(
           padding: EdgeInsets.only(left: 10),
           child: AppBackButton(),
        ),
        title: Text('Find Tours', style: AppTextStyles.displayMedium),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primarySurface,
              child: IconButton(
                onPressed: () => Navigator.push(context, PageTransitions.slideRight(const MapScreen(title: 'Tours Map'))),
                icon: const Icon(Iconsax.map, color: AppColors.primary, size: 18),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          AppSpacing.vMd,
          // ==================== SEARCH BAR ====================
          Padding(
            padding: AppSpacing.screenH,
            child: AppSearchBar(
              hintText: 'Where do you want to explore?',
              showFilter: true,
              onTap: () => Navigator.push(
                context,
                PageTransitions.fadeScale(const SearchScreen()), // Replace with an actual destination/search screen
              ),
            ),
          ).fadeInUp(),
          
          AppSpacing.vLg,

          // ==================== DURATIONS ====================
          CategoryChips(
            categories: _durations,
            selectedIndex: _selectedDuration,
            onSelected: (i) => setState(() => _selectedDuration = i),
            filled: false,
          ).fadeInUp(delay: 50.ms),

          AppSpacing.vLg,

          // ==================== TOUR LIST ====================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              physics: const BouncingScrollPhysics(),
              itemCount: MockData.tours.length,
              itemBuilder: (context, index) {
                final tour = MockData.tours[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: PremiumCard(
                    height: 280,
                    imageUrl: tour['image'],
                    title: tour['name'],
                    subtitle: 'Duration: ${tour['duration']} • ${tour['reviews']} reviews',
                    rating: (tour['rating'] as num).toDouble(),
                    price: (tour['price'] as num).toDouble(),
                    badgeText: 'Top Choice',
                    onTap: () {
                      Navigator.push(context, PageTransitions.fadeScale(TourDetailScreen(tour: tour)));
                    },
                    onBookmarkTap: () {},
                  ).fadeInScale(delay: Duration(milliseconds: 100 + (index * 50))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
