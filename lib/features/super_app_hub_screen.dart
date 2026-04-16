import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../core/widgets/glass_container.dart';
import '../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

// -- Core & Auth --

// -- Content & Discovery --

// -- AI Assistant --
import 'ai_assistant/ai_etiquette_guide_screen.dart';
import 'ai_assistant/ai_translator_screen.dart';
import 'ai_assistant/ai_trip_generator_screen.dart';
import 'ai_assistant/ai_photo_enhancer_screen.dart';
import 'ai_assistant/ai_trip_memory_screen.dart';
import 'ai_assistant/ai_food_matcher_screen.dart';
import 'ai_assistant/ai_flight_radar_screen.dart';
import 'ai_assistant/ai_packing_list_screen.dart';

// -- AR Lens --
import 'ar_lens/metaverse_lounge_screen.dart';
import 'ar_lens/ar_navigation_screen.dart';
import 'ar_lens/ar_luggage_measure_screen.dart';
import 'ar_lens/ar_hotel_portal_screen.dart';
import 'ar_lens/ar_history_time_machine_screen.dart';
import 'ar_lens/ar_virtual_guide_screen.dart';

// -- Gamification --
import 'gamification/global_leaderboard_screen.dart';
import 'gamification/group_voting_screen.dart';
import 'gamification/trip_collab_hub_screen.dart';
import 'gamification/live_friend_tracker_screen.dart';
import 'gamification/travel_passport_screen.dart';
import 'gamification/travel_buddy_matcher_screen.dart';

// -- E-Commerce --
import 'ecommerce/travel_insurance_screen.dart';
import 'ecommerce/car_rental_hub_screen.dart';
import 'ecommerce/train_bus_ticket_screen.dart';
import 'ecommerce/local_guide_market_screen.dart';

// -- Safety & Utils --
import 'safety_utilities/offline_mode_hub_screen.dart';
import 'safety_utilities/public_amenity_finder_screen.dart';
import 'safety_utilities/scam_radar_screen.dart';
import 'safety_utilities/health_passport_screen.dart';

// -- Social --

// ===============================
// App Store Models
// ===============================
class AppStoreItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Widget screen;

  AppStoreItem({required this.title, required this.subtitle, required this.imageUrl, required this.screen});
}

class AppStoreCategory {
  final String title;
  final String description;
  final List<AppStoreItem> apps;

  AppStoreCategory({required this.title, required this.description, required this.apps});
}

class SuperAppHubScreen extends StatefulWidget {
  const SuperAppHubScreen({super.key});

  @override
  State<SuperAppHubScreen> createState() => _SuperAppHubScreenState();
}

class _SuperAppHubScreenState extends State<SuperAppHubScreen> with TickerProviderStateMixin {
  late final List<AppStoreCategory> storeCategories;
  
  @override
  void initState() {
    super.initState();
    storeCategories = _buildStoreData();
  }

  List<AppStoreCategory> _buildStoreData() {
    return [
      AppStoreCategory(
        title: 'New & Noteworthy',
        description: 'Explore the latest futuristic features blending AR and AI.',
        apps: [
          AppStoreItem(title: 'AR Time Machine', subtitle: 'Step into history', imageUrl: 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', screen: const ArHistoryTimeMachineScreen()), // Vietnam Context
          AppStoreItem(title: 'Flight Radar', subtitle: 'Live track VN flights', imageUrl: 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800', screen: const AiFlightRadarScreen()),
          AppStoreItem(title: 'Food Matcher', subtitle: 'Tinder for local dishes', imageUrl: 'https://images.unsplash.com/photo-1533050487297-09b450131914?w=800', screen: const AiFoodMatcherScreen()), // Food context
          AppStoreItem(title: 'Virtual Lounge', subtitle: 'Explore Noi Bai Airport', imageUrl: 'https://images.unsplash.com/photo-1553531384-cc64ac80f931?w=800', screen: const MetaverseLoungeScreen()),
        ],
      ),
      AppStoreCategory(
        title: 'AI Assistant Suite',
        description: 'Your personal smart travel companion.',
        apps: [
          AppStoreItem(title: 'Trip Architect', subtitle: 'Auto-generate plans', imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800', screen: const AiTripGeneratorScreen()),
          AppStoreItem(title: 'Pro Translator', subtitle: 'Communicate easily', imageUrl: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800', screen: const AiTranslatorScreen()),
          AppStoreItem(title: 'Trip Memories', subtitle: 'Auto-create logbooks', imageUrl: 'https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=800', screen: const AiTripMemoryScreen()),
          AppStoreItem(title: 'Magic Enhancer', subtitle: 'Restore travel photos', imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800', screen: const AiPhotoEnhancerScreen()),
          AppStoreItem(title: 'Smart Packing', subtitle: 'Weather-based list for Sapa', imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800', screen: const AiPackingListScreen()),
          AppStoreItem(title: 'Etiquette Guide', subtitle: 'Understand local culture', imageUrl: 'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=800', screen: const AiEtiquetteGuideScreen()),
        ],
      ),
      AppStoreCategory(
        title: 'AR Reality Models',
        description: 'Experience Vietnam through a new dimension.',
        apps: [
          AppStoreItem(title: 'Hotel Portal', subtitle: 'Walk inside InterContinental', imageUrl: 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', screen: const ArHotelPortalScreen()),
          AppStoreItem(title: 'Luggage Measure', subtitle: 'Check Vietjet limits', imageUrl: 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800', screen: const ArLuggageMeasureScreen()),
          AppStoreItem(title: 'AR Navigation', subtitle: 'Follow the arrows in Old Quarter', imageUrl: 'https://images.unsplash.com/photo-1533050487297-09b450131914?w=800', screen: const ArNavigationScreen()),
          AppStoreItem(title: 'Virtual Guide', subtitle: 'Vivid Hue Imperial City', imageUrl: 'https://images.unsplash.com/photo-1553531384-cc64ac80f931?w=800', screen: const ArVirtualGuideScreen()),
        ],
      ),
      AppStoreCategory(
        title: 'Social & Community',
        description: 'Journeys are better when shared with friends.',
        apps: [
          AppStoreItem(title: 'Leaderboard', subtitle: 'Rank globally in Vietnam', imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800', screen: const GlobalLeaderboardScreen()),
          AppStoreItem(title: 'Group Planner', subtitle: 'Finalize Da Lat trips', imageUrl: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800', screen: const TripCollabHubScreen()),
          AppStoreItem(title: 'Group Voting', subtitle: 'What to eat tonight?', imageUrl: 'https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=800', screen: const GroupVotingScreen()),
          AppStoreItem(title: 'Travel Buddy', subtitle: 'Connect with backpackers', imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800', screen: const TravelBuddyMatcherScreen()),
          AppStoreItem(title: 'E-Passport', subtitle: 'Da Nang check-in stamps', imageUrl: 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800', screen: const TravelPassportScreen()),
          AppStoreItem(title: 'Live Tracker', subtitle: 'Don\'t get lost in the market', imageUrl: 'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=800', screen: const LiveFriendTrackerScreen()),
        ],
      ),
      AppStoreCategory(
        title: 'Travel & Bookings',
        description: 'Everything you need for a seamless trip.',
        apps: [
          AppStoreItem(title: 'Car Rental', subtitle: 'Motorbikes & VF8 Cars', imageUrl: 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', screen: const CarRentalHubScreen()),
          AppStoreItem(title: 'Transit Tickets', subtitle: 'Trains & Sleeper Buses', imageUrl: 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800', screen: const TrainBusTicketScreen()),
          AppStoreItem(title: 'Local Experts', subtitle: 'Hire local guides', imageUrl: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800', screen: const LocalGuideMarketScreen()),
          AppStoreItem(title: 'Insurance', subtitle: 'Scooter accident coverage', imageUrl: 'https://images.unsplash.com/photo-1553531384-cc64ac80f931?w=800', screen: const TravelInsuranceScreen()),
        ],
      ),
      AppStoreCategory(
        title: 'Safety & Utilities',
        description: 'Vital tools for peace of mind anywhere.',
        apps: [
          AppStoreItem(title: 'Scam Radar', subtitle: 'High alert tourist zones', imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800', screen: const ScamRadarScreen()),
          AppStoreItem(title: 'Health Hub', subtitle: 'Covid & Vaccine logs', imageUrl: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800', screen: const HealthPassportScreen()),
          AppStoreItem(title: 'Offline Maps', subtitle: 'No internet required', imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800', screen: const OfflineModeHubScreen()),
          AppStoreItem(title: 'Amenity Finder', subtitle: 'Public toilets & Wifi', imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800', screen: const PublicAmenityFinderScreen()),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Prominent App Bar
            SliverAppBar(
              expandedHeight: 140,
              backgroundColor: Colors.transparent, // Fully transparent at rest to blend flawlessly
              surfaceTintColor: Colors.black, // Dark overlay magically appears only when scrolled
              elevation: 0,
              scrolledUnderElevation: 10.0,
              shadowColor: Colors.black.withValues(alpha: 0.5),
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                title: Text('Explore Features', style: AppTextStyles.displayMedium.copyWith(color: Colors.white)),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.primaryDark, Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    const Positioned(
                      right: -30,
                      top: -20,
                      child: Icon(Iconsax.box, size: 200, color: Colors.white10),
                    ),
                  ],
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Iconsax.search_normal, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => SuperAppSearchScreen(categories: storeCategories),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                        )
                      );
                    },
                  ),
                ),
              ],
            ),
            
            // Hero Today Section (First category items dynamically highlighted)
            SliverToBoxAdapter(
              child: _buildHeroCarousel(context, storeCategories[0]),
            ),

            // Store Categories
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) return const SizedBox.shrink(); // Skip the first one which is used in Hero
                  return _buildAnimatedHorizontalCategory(context, storeCategories[index], index);
                },
                childCount: storeCategories.length,
              ),
            ),
            
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCarousel(BuildContext context, AppStoreCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TODAY\'S HIGHLIGHTS', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textTertiary, letterSpacing: 1.5)),
              const SizedBox(height: 4),
              Text(category.title, style: AppTextStyles.displaySmall),
            ],
          ),
        ),
        SizedBox(
          height: 380,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: category.apps.length,
            itemBuilder: (context, index) {
              final app = category.apps[index];
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: Duration(milliseconds: 500 + (index * 100)),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => app.screen)),
                  child: Container(
                    width: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      children: [
                        // Image Background
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: Image.network(
                              app.imageUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Dark Gradient Overlay
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              colors: [Colors.black87, Colors.transparent, Colors.black87],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                        // Content
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(category.description, style: AppTextStyles.labelMedium.copyWith(color: Colors.white70)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(app.title, style: AppTextStyles.displayMedium.copyWith(color: Colors.white)),
                                  const SizedBox(height: 12),
                                  GlassContainer.solid(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    borderRadius: 20,
                                    color: Colors.white.withValues(alpha: 0.2),
                                    child: const Text('Open Feature', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedHorizontalCategory(BuildContext context, AppStoreCategory category, int rowIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category.title, style: AppTextStyles.titleLarge),
                    const SizedBox(height: 4),
                    Text(category.description, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Text('See All', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: category.apps.length,
            itemBuilder: (context, index) {
              final app = category.apps[index];
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 600 + (index * 100)),
                curve: Curves.fastOutSlowIn,
                builder: (context, opacity, child) {
                  return Opacity(
                    opacity: opacity,
                    child: child,
                  );
                },
                child: _buildAppItem(context, app),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAppItem(BuildContext context, AppStoreItem app) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => app.screen)),
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: Image.network(
                    app.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, _, __) => Container(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(Icons.apps, color: AppColors.primary),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(app.title, style: AppTextStyles.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(app.subtitle, style: AppTextStyles.labelSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

// ==================== SUPER APP SEARCH SCREEN ====================
class SuperAppSearchScreen extends StatefulWidget {
  final List<AppStoreCategory> categories;

  const SuperAppSearchScreen({super.key, required this.categories});

  @override
  State<SuperAppSearchScreen> createState() => _SuperAppSearchScreenState();
}

class _SuperAppSearchScreenState extends State<SuperAppSearchScreen> {
  String _query = '';
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  late final List<AppStoreItem> _allItems;
  late final List<AppStoreItem> _suggestedItems;

  @override
  void initState() {
    super.initState();
    _allItems = widget.categories.expand((c) => c.apps).toList();
    // Choose some flashy suggestions for the empty state
    _suggestedItems = _allItems.where((i) => 
      ['Flight Radar', 'Smart Packing', 'Pro Translator', 'Magic Enhancer', 'AR Time Machine', 'Scam Radar'].contains(i.title)
    ).toList();
    if (_suggestedItems.isEmpty) _suggestedItems.addAll(_allItems.take(6));
    
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<AppStoreItem> get _filteredItems {
    if (_query.isEmpty) return [];
    return _allItems.where((item) => 
      item.title.toLowerCase().contains(_query.toLowerCase()) || 
      item.subtitle.toLowerCase().contains(_query.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context), 
                      child: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20)
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          onChanged: (v) => setState(() => _query = v),
                          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            filled: false,
                            fillColor: Colors.transparent,
                            icon: const Icon(Iconsax.search_normal, size: 20, color: AppColors.textTertiary),
                            hintText: 'Search 50+ features...',
                            hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary),
                            border: InputBorder.none,
                            suffixIcon: _query.isNotEmpty ? IconButton(
                              icon: const Icon(Icons.close, size: 18, color: AppColors.textTertiary), 
                              onPressed: () => setState(() { _controller.clear(); _query = ''; })
                            ) : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Title for Results or Suggestions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text(
                  _query.isEmpty ? 'Suggested For You' : 'Search Results', 
                  style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)
                ),
              ),

              // dynamic body
              Expanded(
                child: _query.isEmpty ? _buildSuggestions() : _buildSearchResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: _suggestedItems.length,
      itemBuilder: (context, index) {
        final item = _suggestedItems[index];
        return GestureDetector(
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => item.screen)),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(image: CachedNetworkImageProvider(item.imageUrl), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 12),
                Text(item.title, style: AppTextStyles.labelMedium.copyWith(color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(item.subtitle, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary, fontSize: 10), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    if (_filteredItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.search_status, size: 48, color: Colors.black12),
            const SizedBox(height: 16),
            Text('No features found', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return GestureDetector(
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => item.screen)),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(imageUrl: item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: AppTextStyles.titleSmall.copyWith(color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Text(item.subtitle, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textTertiary, size: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}


