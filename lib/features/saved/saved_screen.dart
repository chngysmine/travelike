import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_search_bar.dart';
import '../../core/widgets/category_chips.dart';
import '../../core/widgets/premium_card.dart';
import '../../core/utils/app_animations.dart';
import '../../data/mock_data.dart';
import '../search/search_screen.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = ['All', 'Destinations', 'Hotels', 'Tours', 'Events', 'Food'];

  // Combine some mock data to act as "saved" items
  final List<Map<String, dynamic>> _savedItems = [
    ...MockData.destinations.map((d) => {...d, 'type': 'Destinations'}),
    ...MockData.tours.map((t) => {...t, 'type': 'Tours', 'location': t['duration']}),
    ...MockData.events.map((e) => {...e, 'type': 'Events', 'rating': 5.0}),
  ];

  List<Map<String, dynamic>> get _filteredItems {
    if (_selectedCategory == 0) return _savedItems;
    final cat = _categories[_selectedCategory];
    return _savedItems.where((item) => item['type'] == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('Saved', style: AppTextStyles.displayMedium),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('${_savedItems.length} items', style: AppTextStyles.labelMedium.secondary),
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
              hintText: 'Search your saved items...',
              showFilter: true,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
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
          ).fadeInUp(delay: 100.ms),

          AppSpacing.vLg,

          // ==================== SAVED ITEMS GRID ====================
          Expanded(
            child: _filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.bookmark_border_rounded, size: 64, color: AppColors.textTertiary),
                        AppSpacing.vMd,
                        Text('No items saved yet', style: AppTextStyles.titleLarge.tertiary),
                        AppSpacing.vSm,
                        Text('Explore and save your favorites.', style: AppTextStyles.bodyMedium),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      // Use a smaller height for grid
                      return PremiumCard.destination(
                        data: item,
                        isBookmarked: true,
                        onBookmarkTap: () {},
                        onTap: () {},
                      ).fadeInScale(index: index);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
