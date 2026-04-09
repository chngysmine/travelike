import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import '../settings/settings_screen.dart';
import 'edit_profile_screen.dart';
import '../social/message_screen.dart';

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
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const SizedBox(width: 32),
                  const Spacer(),
                  Text('Profile', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(context, PageTransitions.slideRight(const SettingsScreen())),
                    child: const Icon(Iconsax.setting_2, size: 22),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 24),
            // Avatar
            GestureDetector(
              onTap: () => Navigator.push(context, PageTransitions.slideRight(const EditProfileScreen())),
              child: Stack(
                children: [
                  Container(
                    width: 120, height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3), width: 4),
                      boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 8))],
                    ),
                    child: ClipOval(child: CachedNetworkImage(imageUrl: MockData.userAvatar, fit: BoxFit.cover)),
                  ),
                  Positioned(
                    bottom: 4, right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                      child: const Icon(Iconsax.edit, size: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms, delay: 100.ms).scale(begin: const Offset(0.8, 0.8)),
            const SizedBox(height: 16),
            Text(MockData.userFullName, style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary)).animate().fadeIn(duration: 400.ms, delay: 200.ms),
            const SizedBox(height: 4),
            Text(MockData.userBio.split('\n')[0], style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)).animate().fadeIn(duration: 400.ms, delay: 250.ms),
            const SizedBox(height: 16),
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StatItem(count: '350', label: 'Following'),
                Container(height: 30, width: 1, margin: const EdgeInsets.symmetric(horizontal: 24), color: Colors.grey.shade300),
                _StatItem(count: '346', label: 'Followers'),
                Container(height: 30, width: 1, margin: const EdgeInsets.symmetric(horizontal: 24), color: Colors.grey.shade300),
                _StatItem(count: '12', label: 'Posts'),
              ],
            ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
            const SizedBox(height: 24),
            // Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, PageTransitions.slideRight(const EditProfileScreen())),
                      icon: const Icon(Iconsax.edit, size: 18),
                      label: Text('Edit', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.push(context, PageTransitions.slideRight(const MessageScreen())),
                      icon: const Icon(Iconsax.message, size: 18),
                      label: Text('Messages', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary.withValues(alpha: 0.5)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
            const SizedBox(height: 28),
            // Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textTertiary,
                indicatorColor: AppColors.primary,
                indicatorWeight: 2.5,
                labelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
                unselectedLabelStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
                tabs: const [Tab(text: 'ABOUT'), Tab(text: 'EVENT'), Tab(text: 'REVIEWS')],
              ),
            ),
            SizedBox(
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: [_AboutTab(), _EventTab(), _ReviewsTab()],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;
  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(count, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
    ]);
  }
}

class _AboutTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(MockData.userBio, style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary, height: 1.6)),
        const SizedBox(height: 16),
        Text('Interest', style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          _InterestChip('Games Online', AppColors.chipGreen),
          _InterestChip('Concert', AppColors.chipRed),
          _InterestChip('Music', AppColors.chipOrange),
          _InterestChip('Art', AppColors.chipPurple),
          _InterestChip('Movie', AppColors.chipBlue),
          _InterestChip('Travel', AppColors.chipTeal),
          _InterestChip('Food', AppColors.categoryFood),
        ]),
      ]),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final String label;
  final Color color;
  const _InterestChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
    );
  }
}

class _EventTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: MockData.events.length > 5 ? 5 : MockData.events.length,
      itemBuilder: (context, index) {
        final event = MockData.events[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(16)),
          child: Row(children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(imageUrl: event['image'], width: 70, height: 70, fit: BoxFit.cover)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(event['date'], style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),
              const SizedBox(height: 4),
              Text(event['title'], maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
            ])),
          ]),
        );
      },
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reviews = [
      {'name': 'Rocks Velkeinjen', 'date': '10 Feb', 'rating': 4, 'text': 'Amazing travel companion app! Every feature I need in one place.', 'avatar': MockData.avatar3},
      {'name': 'Angelina Zolly', 'date': '8 Feb', 'rating': 5, 'text': 'The best way to explore Vietnam! Love the food recommendations.', 'avatar': MockData.avatar4},
      {'name': 'Zenifero Bolex', 'date': '5 Feb', 'rating': 5, 'text': 'Incredible experience! Would definitely recommend to friends.', 'avatar': MockData.avatar5},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              CircleAvatar(radius: 18, backgroundImage: CachedNetworkImageProvider(review['avatar'] as String)),
              const SizedBox(width: 10),
              Expanded(child: Text(review['name'] as String, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600))),
              Text(review['date'] as String, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
            ]),
            const SizedBox(height: 8),
            Row(children: List.generate(5, (i) => Icon(Icons.star, size: 16, color: i < (review['rating'] as int) ? AppColors.accentGold : Colors.grey.shade300))),
            const SizedBox(height: 8),
            Text(review['text'] as String, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
          ]),
        );
      },
    );
  }
}
