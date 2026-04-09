import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import 'restaurant_detail_screen.dart';

class LocalDishupScreen extends StatefulWidget {
  const LocalDishupScreen({super.key});

  @override
  State<LocalDishupScreen> createState() => _LocalDishupScreenState();
}

class _LocalDishupScreenState extends State<LocalDishupScreen> {
  int _selectedCategory = 0;

  List<Map<String, dynamic>> get _filteredFoods {
    if (_selectedCategory == 0) return MockData.foods;
    return MockData.foods.where((f) => f['category'] == MockData.foodCategories[_selectedCategory]).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20)),
                    const SizedBox(width: 12),
                    Text('Menu', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (MockData.restaurants.isNotEmpty) {
                          Navigator.push(context, PageTransitions.slideRight(RestaurantDetailScreen(restaurant: MockData.restaurants[0])));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Iconsax.shop, size: 16, color: Colors.white),
                          const SizedBox(width: 6),
                          Text('Restaurants', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),
              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)]),
                  child: Row(children: [
                    const Icon(Iconsax.search_normal, size: 20, color: AppColors.textTertiary),
                    const SizedBox(width: 12),
                    Expanded(child: Text('Search Vietnamese dishes...', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textTertiary))),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Iconsax.filter, size: 16, color: AppColors.primary),
                    ),
                  ]),
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
              const SizedBox(height: 16),
              // Categories
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: MockData.foodCategories.length,
                  itemBuilder: (_, index) {
                    final isSelected = _selectedCategory == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade300),
                        ),
                        child: Center(child: Text(MockData.foodCategories[index], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppColors.textSecondary))),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('${_filteredFoods.length} dishes', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textTertiary)),
              ),
              const SizedBox(height: 12),
              // Food Grid
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.72, crossAxisSpacing: 12, mainAxisSpacing: 12),
                  itemCount: _filteredFoods.length,
                  itemBuilder: (context, index) {
                    final food = _filteredFoods[index];
                    return GestureDetector(
                      onTap: () => _showFoodDetail(context, food),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                              child: Stack(children: [
                                CachedNetworkImage(imageUrl: food['image'], height: 120, width: double.infinity, fit: BoxFit.cover),
                                Positioned(top: 8, right: 8, child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(6)),
                                  child: Row(children: [const Icon(Icons.star_rounded, size: 12, color: AppColors.accentGold), Text(' ${food['rating']}', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600))]),
                                )),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(food['name'], maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Row(children: [
                                  Text('\$${food['price'].toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                                    child: const Icon(Icons.add, size: 16, color: Colors.white),
                                  ),
                                ]),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1.0, 1.0));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFoodDetail(BuildContext context, Map<String, dynamic> food) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            ClipRRect(borderRadius: BorderRadius.circular(20), child: CachedNetworkImage(imageUrl: food['image'], height: 200, width: double.infinity, fit: BoxFit.cover)),
            const SizedBox(height: 16),
            Text(food['name'], style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Row(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(8)), child: Text(food['category'], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primary))),
              const Spacer(),
              const Icon(Icons.star_rounded, size: 16, color: AppColors.accentGold),
              Text(' ${food['rating']}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
            ]),
            const SizedBox(height: 12),
            Text('${food['available']} available', style: GoogleFonts.inter(fontSize: 13, color: AppColors.chipGreen)),
            const SizedBox(height: 16),
            // Quantity
            Row(children: [
              Text('\$${food['price'].toStringAsFixed(2)}', style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.primary)),
              const Spacer(),
              Container(
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.remove, size: 18)),
                  Text('1', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add, size: 18)),
                ]),
              ),
            ]),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 56, child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: Text('Add to Order', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
            )),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
