import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/utils/app_animations.dart';
import '../../data/mock_data.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _localReels = [
    {
      'id': '1',
      'thumbnail': 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
      'user': 'Huy Tran',
      'userAvatar': MockData.avatar1,
      'caption': 'Lost in the beauty of Ha Long Bay 🌊 Mọi người nhớ đến đây nhé!',
      'likes': 12400,
      'comments': 342,
      'shares': 120,
      'tags': ['halong', 'vietnam', 'travel'],
      'location': 'Ha Long Bay',
    },
    {
      'id': '2',
      'thumbnail': 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800',
      'user': 'Ngan Chau',
      'userAvatar': MockData.avatar2,
      'caption': 'Hoi An nights are pure magic ✨🏮 #hoian #lantern',
      'likes': 8900,
      'comments': 215,
      'shares': 89,
      'tags': ['hoian', 'magic', 'nightlife'],
      'location': 'Hoi An City',
    },
    {
      'id': '3',
      'thumbnail': 'https://images.unsplash.com/photo-1533050487297-09b450131914?w=800',
      'user': 'Tuan Nguyen',
      'userAvatar': MockData.avatar3,
      'caption': 'Da Nang vibes with the best squad 🏖️',
      'likes': 5600,
      'comments': 120,
      'shares': 45,
      'tags': ['danang', 'beach', 'summer'],
      'location': 'My Khe Beach',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ==================== VERTICAL PAGER ====================
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: _localReels.length,
            itemBuilder: (context, index) {
              return _ReelItem(
                reel: _localReels[index],
                isActive: _currentIndex == index,
              );
            },
          ),

          // ==================== TOP NAVIGATION / CAMERA ====================
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reels',
                  style: AppTextStyles.displayMedium.white,
                ).fadeInSimple(),
                GestureDetector(
                  onTap: () {},
                  child: GlassContainer.dark(
                    width: 44,
                    height: 44,
                    borderRadius: AppSpacing.radiusRound,
                    child: const Icon(Iconsax.camera, color: Colors.white, size: 22),
                  ),
                ).fadeInSimple(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReelItem extends StatefulWidget {
  final Map<String, dynamic> reel;
  final bool isActive;

  const _ReelItem({required this.reel, required this.isActive});

  @override
  State<_ReelItem> createState() => _ReelItemState();
}

class _ReelItemState extends State<_ReelItem> with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  bool _showHeart = false;
  late AnimationController _heartController;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    setState(() {
      _isLiked = true;
      _showHeart = true;
    });
    _heartController.forward(from: 0).then((_) {
      setState(() => _showHeart = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ==================== VIDEO PLACEHOLDER ====================
          CachedNetworkImage(
            imageUrl: widget.reel['thumbnail'],
            fit: BoxFit.cover,
          ),
          
          // ==================== GRADIENT OVERLAY ====================
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                ],
                stops: const [0.0, 0.2, 0.6, 1.0],
              ),
            ),
          ),

          // ==================== HEARTS ANIMATION ====================
          if (_showHeart)
            Center(
              child: const Icon(
                Icons.favorite_rounded,
                color: AppColors.chipRed,
                size: 100,
              )
                  .animate(controller: _heartController)
                  .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.2, 1.2), duration: 300.ms, curve: Curves.elasticOut)
                  .fadeOut(delay: 300.ms, duration: 300.ms),
            ),

          // ==================== RIGHT ACTIONS ====================
          Positioned(
            right: 16,
            bottom: 100, // accommodate bottom nav
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ActionItem(
                  icon: _isLiked ? Icons.favorite_rounded : Iconsax.heart,
                  label: '${widget.reel['likes'] + (_isLiked ? 1 : 0)}',
                  color: _isLiked ? AppColors.chipRed : Colors.white,
                  onTap: () => setState(() => _isLiked = !_isLiked),
                ),
                AppSpacing.vLg,
                _ActionItem(
                  icon: Iconsax.message,
                  label: '${widget.reel['comments']}',
                  onTap: () => _showCommentsBottomSheet(context),
                ),
                AppSpacing.vLg,
                _ActionItem(
                  icon: Icons.send_rounded,
                  label: '${widget.reel['shares']}',
                  onTap: () {},
                ),
                AppSpacing.vXxl,
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    image: const DecorationImage(
                      image: CachedNetworkImageProvider('https://images.unsplash.com/photo-1553531384-cc64ac80f931?w=800'), // Music disk
                      fit: BoxFit.cover,
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat()).rotate(duration: 5.seconds),
              ],
            ).fadeInUp(delay: 200.ms),
          ),

          // ==================== BOTTOM INFO ====================
          Positioned(
            left: 20,
            right: 80,
            bottom: 24, // Shifted to make space for bottom nav overlapping
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: CachedNetworkImageProvider(widget.reel['userAvatar']),
                    ),
                    AppSpacing.hMd,
                    Text(
                      widget.reel['user'],
                      style: AppTextStyles.titleMedium.white,
                    ),
                    AppSpacing.hMd,
                    GlassContainer.dark(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      borderRadius: AppSpacing.radiusRound,
                      child: Text('Follow', style: AppTextStyles.labelSmall.white),
                    ),
                  ],
                ),
                AppSpacing.vMd,
                Text(
                  widget.reel['caption'],
                  style: AppTextStyles.bodyMedium.white,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.vSm,
                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.reel['tags']
                      .map<Widget>((tag) => GlassContainer.dark(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            borderRadius: AppSpacing.radiusSm,
                            child: Text('#$tag', style: AppTextStyles.labelSmall.white.copyWith(fontWeight: FontWeight.w600)),
                          ))
                      .toList(),
                ),
                AppSpacing.vMd,
                Row(
                  children: [
                    const Icon(Icons.music_note_rounded, size: 16, color: Colors.white),
                    AppSpacing.hSm,
                    Expanded(
                      child: Text(
                        'Original Audio • ${widget.reel['location']}',
                        style: AppTextStyles.labelSmall.white,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                // Safety space for bottom navigation bar shadow & layout
                const SizedBox(height: 70),
              ],
            ).fadeInUp(delay: 100.ms),
          ),
        ],
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer.light(
        borderRadius: 28,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 40),
        child: Column(
          children: [
            AppSpacing.vMd,
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2))),
            AppSpacing.vLg,
            Text('${widget.reel['comments']} Comments', style: AppTextStyles.titleMedium),
            AppSpacing.vLg,
            Expanded(
              child: ListView.builder(
                padding: AppSpacing.screenH,
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: CachedNetworkImageProvider(MockData.teamMembers[index % MockData.teamMembers.length]['avatar'] ?? ''),
                      ),
                      AppSpacing.hMd,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(MockData.teamMembers[index % MockData.teamMembers.length]['name'] ?? 'User', style: AppTextStyles.labelMedium.secondary),
                                AppSpacing.hSm,
                                Text('2h', style: AppTextStyles.labelSmall),
                              ],
                            ),
                            AppSpacing.vXs,
                            Text(
                              'This looks absolutely amazing! Need to add this to my travel bucket list 😍',
                              style: AppTextStyles.bodyMedium,
                            ),
                            AppSpacing.vSm,
                            Text('Reply', style: AppTextStyles.labelSmall.secondary),
                          ],
                        ),
                      ),
                      const Icon(Iconsax.heart, size: 16, color: AppColors.textTertiary),
                    ],
                  ),
                ),
              ),
            ),
            // Comment input field
            Container(
              padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.withValues(alpha: 0.1))),
              ),
              child: Row(
                children: [
                  CircleAvatar(radius: 18, backgroundImage: CachedNetworkImageProvider(MockData.userAvatar)),
                  AppSpacing.hMd,
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: AppSpacing.borderRound,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          hintStyle: AppTextStyles.bodyMedium.tertiary,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.hMd,
                  const Icon(Icons.send_rounded, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionItem({required this.icon, required this.label, this.color = Colors.white, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          AppSpacing.vXs,
          Text(label, style: AppTextStyles.labelMedium.white),
        ],
      ),
    );
  }
}
