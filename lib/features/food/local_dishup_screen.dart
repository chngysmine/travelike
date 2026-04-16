import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_search_bar.dart';
import '../../core/widgets/category_chips.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/app_back_button.dart';
import '../../core/utils/app_animations.dart';
import '../../core/utils/page_transitions.dart';
import 'restaurant_detail_screen.dart';

class LocalDishupScreen extends StatefulWidget {
  const LocalDishupScreen({super.key});

  @override
  State<LocalDishupScreen> createState() => _LocalDishupScreenState();
}

class _LocalDishupScreenState extends State<LocalDishupScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = ['All', 'Street Food', 'Noodles', 'Seafood', 'Desserts', 'Drinks'];

  final List<Map<String, dynamic>> _localFoods = [
    {
      'id': '1', 'name': 'Phở Bò Mộc', 'category': 'Noodles', 'rating': 4.9, 'reviews': 512, 'price': 3.5,
      'image': 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
    },
    {
      'id': '2', 'name': 'Bánh Mì Hội An', 'category': 'Street Food', 'rating': 4.8, 'reviews': 890, 'price': 1.5,
      'image': 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800',
    },
    {
      'id': '3', 'name': 'Cà Phê Trứng', 'category': 'Drinks', 'rating': 4.7, 'reviews': 324, 'price': 2.0,
      'image': 'https://images.unsplash.com/photo-1533050487297-09b450131914?w=800',
    },
    {
      'id': '4', 'name': 'Gỏi Cuốn', 'category': 'Street Food', 'rating': 4.6, 'reviews': 412, 'price': 2.5,
      'image': 'https://images.unsplash.com/photo-1553531384-cc64ac80f931?w=800',
    },
    {
      'id': '5', 'name': 'Bún Chả Hà Nội', 'category': 'Noodles', 'rating': 4.9, 'reviews': 678, 'price': 4.0,
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800',
    },
    {
      'id': '6', 'name': 'Chè Khúc Bạch', 'category': 'Desserts', 'rating': 4.5, 'reviews': 120, 'price': 1.8,
      'image': 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800',
    },
  ];

  List<Map<String, dynamic>> get _filteredFoods {
    if (_selectedCategory == 0) return _localFoods;
    final cat = _categories[_selectedCategory];
    return _localFoods.where((f) => f['category'] == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ==================== APP BAR ====================
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.backgroundLight,
            leading: const Padding(
              padding: EdgeInsets.only(left: 10, top: 4),
              child: AppBackButton(),
            ),
            title: Text('Local Dishup', style: AppTextStyles.displayMedium),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 4),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, PageTransitions.fadeScale(const RestaurantDetailScreen())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: AppSpacing.borderLg),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Iconsax.shop, size: 16, color: Colors.white),
                        AppSpacing.hSm,
                        Text('Restaurants', style: AppTextStyles.labelMedium.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ==================== SEARCH & FILTERS ====================
          SliverToBoxAdapter(
            child: Column(
              children: [
                AppSpacing.vLg,
                Padding(
                  padding: AppSpacing.screenH,
                  child: const AppSearchBar(
                    hintText: 'Search Vietnamese dishes...',
                    showFilter: true,
                  ),
                ).fadeInUp(),
                
                AppSpacing.vLg,
                
                CategoryChips(
                  categories: _categories,
                  selectedIndex: _selectedCategory,
                  onSelected: (i) => setState(() => _selectedCategory = i),
                  filled: false,
                ).fadeInUp(delay: 50.ms),
                
                AppSpacing.vLg,
                
                Padding(
                  padding: AppSpacing.screenH,
                  child: Row(
                    children: [
                      Text('${_filteredFoods.length} dishes', style: AppTextStyles.labelMedium.secondary),
                      const Spacer(),
                      const Icon(Icons.sort_rounded, size: 20, color: AppColors.textTertiary),
                      AppSpacing.hSm,
                      Text('Popular', style: AppTextStyles.labelMedium),
                    ],
                  ),
                ),
                AppSpacing.vMd,
              ],
            ),
          ),

          // ==================== FOOD GRID ====================
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final food = _filteredFoods[index];
                  return _FoodCard(
                    food: food,
                    delay: 100 + (index * 50),
                  );
                },
                childCount: _filteredFoods.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  final Map<String, dynamic> food;
  final int delay;

  const _FoodCard({required this.food, required this.delay});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFoodDetail(context, food),
      child: GlassContainer.solid(
        padding: EdgeInsets.zero,
        borderRadius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: food['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GlassContainer.light(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      borderRadius: 12,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, size: 14, color: AppColors.accentGold),
                          const SizedBox(width: 2),
                          Text('${food['rating']}', style: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info Area
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      food['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleMedium,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '\$${food['price'].toStringAsFixed(2)}',
                            style: AppTextStyles.price.copyWith(fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, size: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).fadeInScale(), // Removed delay to fix missing named parameter
    );
  }

  void _showFoodDetail(BuildContext context, Map<String, dynamic> food) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            AppSpacing.vXxl,
            ClipRRect(
              borderRadius: AppSpacing.borderXxl,
              child: CachedNetworkImage(
                imageUrl: food['image'],
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            AppSpacing.vXxl,
            Row(
              children: [
                Expanded(child: Text(food['name'], style: AppTextStyles.displayMedium)),
                const Icon(Icons.star_rounded, size: 24, color: AppColors.accentGold),
                AppSpacing.hSm,
                Text('${food['rating']}', style: AppTextStyles.titleLarge),
              ],
            ),
            AppSpacing.vMd,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderSm),
              child: Text(food['category'], style: AppTextStyles.labelMedium.primary),
            ),
            AppSpacing.vXxl,
            Text(
              'A traditional Vietnamese dish that brings out the authentic taste of the culture. Made with fresh ingredients, local herbs, and our secret family recipe that has been refined over generations.',
              style: AppTextStyles.bodyMedium,
            ),
            AppSpacing.vXxl,
            Row(
              children: [
                Text('\$${food['price'].toStringAsFixed(2)}', style: AppTextStyles.displayLarge.primary),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: AppSpacing.borderLg,
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.remove, size: 20)),
                      Text('1', style: AppTextStyles.titleLarge),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.add, size: 20, color: AppColors.primary)),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.vXxl,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Add to Order'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
