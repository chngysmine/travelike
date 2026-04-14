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
import 'hotel_detail_screen.dart';

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({super.key});

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = ['All', 'Resorts', '5 Stars', 'Villas', 'Homestays'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leading: const Padding(
           padding: EdgeInsets.only(left: 10),
           child: AppBackButton(),
        ),
        title: Text('Stays & Hotels', style: AppTextStyles.displayMedium),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primarySurface,
              child: IconButton(
                onPressed: () => Navigator.push(context, PageTransitions.slideRight(const MapScreen(title: 'Hotels Map'))),
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
              hintText: 'City, Landmark, or Hotel',
              showFilter: true,
              onTap: () => Navigator.push(
                context,
                PageTransitions.fadeScale(const SearchScreen()), 
              ),
            ),
          ).fadeInUp(),
          
          AppSpacing.vLg,

          // ==================== CATEGORIES ====================
          CategoryChips(
            categories: _categories,
            selectedIndex: _selectedCategory,
            onSelected: (i) => setState(() => _selectedCategory = i),
            filled: false,
          ).fadeInUp(delay: 50.ms),

          AppSpacing.vLg,

          // ==================== HOTEL LIST ====================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              physics: const BouncingScrollPhysics(),
              itemCount: MockData.hotels.length,
              itemBuilder: (context, index) {
                final hotel = MockData.hotels[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: PremiumCard(
                    height: 300,
                    imageUrl: hotel['image'],
                    title: '${hotel['name']}',
                    subtitle: '📍 ${hotel['location']}',
                    rating: (hotel['rating'] as num).toDouble(),
                    price: 150.0 + (index * 50),
                    badgeText: 'Breakfast Included',
                    onTap: () {
                      Navigator.push(context, PageTransitions.fadeScale(HotelDetailScreen(hotel: hotel)));
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
