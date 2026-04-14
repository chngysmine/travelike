import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/utils/app_animations.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import '../settings/settings_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
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
              expandedHeight: 400,
              pinned: true,
              backgroundColor: AppColors.backgroundLight,
              actions: [
                GestureDetector(
                  onTap: () => Navigator.push(context, PageTransitions.slideRight(const SettingsScreen())),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: AppSpacing.shadowSm),
                    child: const Icon(Iconsax.setting_2, size: 20, color: AppColors.textPrimary),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Cover Photo
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 200,
                      child: CachedNetworkImage(
                        imageUrl: 'https://images.unsplash.com/photo-1546272989-40c92939c6c2?q=80&w=1200&auto=format&fit=crop', // Halong Bay Cover
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient overlay for reading status bar
                    Positioned(
                      top: 0, left: 0, right: 0, height: 100,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter, end: Alignment.bottomCenter,
                            colors: [Colors.black.withValues(alpha: 0.5), Colors.transparent],
                          ),
                        ),
                      ),
                    ),
                    // Profile Content
                    Positioned(
                      top: 150,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          // Avatar & Edit button
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(color: AppColors.backgroundLight, shape: BoxShape.circle),
                                child: CircleAvatar(
                                  radius: 46,
                                  backgroundImage: CachedNetworkImageProvider(MockData.userAvatar),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(context, PageTransitions.slideUp(const EditProfileScreen())),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.backgroundLight, width: 3),
                                  ),
                                  child: const Icon(Iconsax.edit_2, color: Colors.white, size: 14),
                                ),
                              ),
                            ],
                          ).fadeInScale(),
                          AppSpacing.vLg,
                          // Name & Bio
                          Text(MockData.userFullName, style: AppTextStyles.displayMedium).fadeInUp(delay: 100.ms),
                          AppSpacing.vXs,
                          Text('Traveler, Foodie, Photographer ✨', style: AppTextStyles.bodyMedium).fadeInUp(delay: 150.ms),
                          AppSpacing.vLg,
                          // Stats Bar
                          Padding(
                            padding: AppSpacing.screenH,
                            child: GlassContainer.solid(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              borderRadius: 24,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _StatBlock(title: 'Following', value: '254'),
                                  Container(width: 1, height: 30, color: Colors.grey.withValues(alpha: 0.2)),
                                  _StatBlock(title: 'Followers', value: '1.2K'),
                                  Container(width: 1, height: 30, color: Colors.grey.withValues(alpha: 0.2)),
                                  _StatBlock(title: 'Trips', value: '45'),
                                ],
                              ),
                            ).fadeInUp(delay: 200.ms),
                          ),
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
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  indicator: UnderlineTabIndicator(
                    borderSide: const BorderSide(color: AppColors.primary, width: 3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
                  tabs: const [
                    Tab(text: 'Photos'),
                    Tab(text: 'Reviews'),
                    Tab(text: 'Interests'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Photos Tab
            GridView.builder(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 100),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 15,
              itemBuilder: (context, index) {
                final imgs = [
                  MockData.imgHaLongBay,
                  MockData.imgDaNang,
                  MockData.imgHue,
                ];
                return CachedNetworkImage(
                  imageUrl: imgs[index % 3],
                  fit: BoxFit.cover,
                ).fadeInSimple(delay: Duration(milliseconds: index * 30));
              },
            ),
            // Reviews Tab
            ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: AppSpacing.card,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppSpacing.borderLg,
                    boxShadow: AppSpacing.shadowSm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: AppSpacing.borderSm,
                            child: CachedNetworkImage(
                              imageUrl: MockData.tours[index % MockData.tours.length]['image'],
                              width: 40, height: 40, fit: BoxFit.cover,
                            ),
                          ),
                          AppSpacing.hMd,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(MockData.tours[index % MockData.tours.length]['name'], style: AppTextStyles.labelMedium),
                                Row(children: List.generate(5, (_) => const Icon(Icons.star, size: 12, color: AppColors.accentGold))),
                              ],
                            ),
                          ),
                          Text('2w ago', style: AppTextStyles.labelSmall),
                        ],
                      ),
                      AppSpacing.vMd,
                      Text(
                        'Amazing experience! The tour guide was very knowledgeable and the views were breathtaking.',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ).fadeInUp(index: index);
              },
            ),
            // Interests Tab
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: MockData.settingsItems.map((e) => GlassContainer.solid(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  borderRadius: 20,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(e['icon'] as String, style: const TextStyle(fontSize: 16)),
                      AppSpacing.hSm,
                      Text(e['title'] as String, style: AppTextStyles.labelMedium),
                    ],
                  ),
                )).toList(),
              ),
            ).fadeInUp(),
          ],
        ),
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String title;
  final String value;
  const _StatBlock({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.titleLarge.primary),
        AppSpacing.vXs,
        Text(title, style: AppTextStyles.labelSmall),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _SliverAppBarDelegate(this.tabBar);

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
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
