import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/app_back_button.dart';
import '../../core/utils/app_animations.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 320,
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
                      imageUrl: 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black38, Colors.transparent, Colors.black87],
                          stops: [0.0, 0.4, 1.0],
                        ),
                      ),
                    ),
                    // Info Overlay
                    Positioned(
                      bottom: 24,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: AppColors.primary, borderRadius: AppSpacing.borderSm),
                            child: Text('Vietnamese Cuisine', style: AppTextStyles.labelSmall.white),
                          ).fadeInUp(),
                          AppSpacing.vLg,
                          Text('Madam Yen Restaurant', style: AppTextStyles.displayMedium.white).fadeInUp(delay: 50.ms),
                          AppSpacing.vSm,
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: AppColors.accentGold, size: 18),
                              const SizedBox(width: 4),
                              Text('4.8 (856 reviews)', style: AppTextStyles.labelMedium.white),
                              AppSpacing.hLg,
                              const Icon(Iconsax.location, color: Colors.white70, size: 16),
                              const SizedBox(width: 4),
                              Text('Hoan Kiem, Hanoi', style: AppTextStyles.labelMedium.white70),
                            ],
                          ).fadeInUp(delay: 100.ms),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _RestaurantTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  indicator: UnderlineTabIndicator(
                    borderSide: const BorderSide(color: AppColors.primary, width: 3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
                  tabs: const [
                    Tab(text: 'Menu'),
                    Tab(text: 'Reviews'),
                    Tab(text: 'About'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // MENU TAB
            ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              physics: const BouncingScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _MenuItem(
                  name: 'Pho Bo (Beef Noodle Soup) - Special',
                  desc: 'Traditional Vietnamese soup consisting of broth, rice noodles, herbs, and beef.',
                  price: 8.50,
                  image: 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800',
                  delay: index * 50,
                );
              },
            ),
            
            // REVIEWS TAB
            ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const _ReviewItem().fadeInUp(delay: Duration(milliseconds: index * 50));
              },
            ),
            
            // ABOUT TAB
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Location & Timing', style: AppTextStyles.titleLarge),
                  AppSpacing.vLg,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderLg),
                        child: const Icon(Iconsax.location, color: AppColors.primary),
                      ),
                      AppSpacing.hLg,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Location', style: AppTextStyles.labelSmall.secondary),
                            AppSpacing.vXs,
                            Text('99 Hang Gai Street, Hoan Kiem\nHanoi, Vietnam', style: AppTextStyles.labelMedium),
                          ],
                        ),
                      )
                    ],
                  ).fadeInUp(),
                  AppSpacing.vLg,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: AppSpacing.borderLg),
                        child: const Icon(Iconsax.clock, color: AppColors.primary),
                      ),
                      AppSpacing.hLg,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Opening Hours', style: AppTextStyles.labelSmall.secondary),
                            AppSpacing.vXs,
                            Text('Mon - Sun: 10:00 AM - 10:00 PM', style: AppTextStyles.labelMedium),
                          ],
                        ),
                      )
                    ],
                  ).fadeInUp(delay: 50.ms),
                  AppSpacing.vXxl,
                  Text('Amenities', style: AppTextStyles.titleLarge),
                  AppSpacing.vLg,
                  Wrap(
                    spacing: 12, runSpacing: 12,
                    children: [
                      _AmenityChip('Wifi', Iconsax.wifi),
                      _AmenityChip('Air Con', Iconsax.wind),
                      _AmenityChip('Parking', Icons.local_parking_rounded),
                      _AmenityChip('Cards', Iconsax.card),
                    ],
                  ).fadeInUp(delay: 100.ms),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -4))],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Call'),
              ),
            ),
            AppSpacing.hMd,
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Reserve Table'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String name;
  final String desc;
  final double price;
  final String image;
  final int delay;

  const _MenuItem({required this.name, required this.desc, required this.price, required this.image, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppSpacing.borderXl,
        boxShadow: AppSpacing.shadowSm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: AppSpacing.borderLg,
            child: CachedNetworkImage(
              imageUrl: image,
              width: 80, height: 80, fit: BoxFit.cover,
            ),
          ),
          AppSpacing.hLg,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.titleMedium),
                AppSpacing.vXs,
                Text(desc, style: AppTextStyles.labelSmall.secondary, maxLines: 2, overflow: TextOverflow.ellipsis),
                AppSpacing.vLg,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${price.toStringAsFixed(2)}', style: AppTextStyles.price),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: AppSpacing.borderRound,
                      ),
                      child: Text('Add', style: AppTextStyles.labelMedium.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).fadeInUp(delay: Duration(milliseconds: delay));
  }
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider('https://images.unsplash.com/photo-1533050487297-09b450131914?w=800'),
              ),
              AppSpacing.hMd,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sarah Jenkins', style: AppTextStyles.titleMedium),
                    Row(
                      children: [
                        ...List.generate(5, (_) => const Icon(Icons.star_rounded, size: 14, color: AppColors.accentGold)),
                        AppSpacing.hSm,
                        Text('1 week ago', style: AppTextStyles.labelSmall.secondary),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.vMd,
          Text(
            'Absolutely incredible food and service! The Pho here is the best I have ever had outside of Hanoi itself. Highly recommend the spring rolls as well.',
            style: AppTextStyles.bodyMedium,
          ),
          AppSpacing.vLg,
          Divider(color: Colors.grey.withValues(alpha: 0.1)),
        ],
      ),
    );
  }
}

class _AmenityChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _AmenityChip(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return GlassContainer.solid(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textPrimary),
          AppSpacing.hSm,
          Text(label, style: AppTextStyles.labelMedium),
        ],
      ),
    );
  }
}

class _RestaurantTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _RestaurantTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.backgroundLight,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_RestaurantTabBarDelegate oldDelegate) => false;
}
