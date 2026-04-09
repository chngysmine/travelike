import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedRegion = 'Đà Nẵng';

  final List<Map<String, dynamic>> _reels = [
    {
      'user': 'chaungn.travel',
      'avatar': MockData.avatar2,
      'image': MockData.imgHoiAn,
      'likes': 5200,
      'comments': 623,
      'shares': 178,
      'caption': 'Hội An cổ kính dưới ánh đèn lồng ✨ Mỗi lần đến đây lại thấy yêu Việt Nam thêm #HoiAn #Vietnam #Lanterns',
      'music': '🎵 Nhạc Trịnh - Diễm Xưa',
    },
    {
      'user': 'foodie.danang',
      'avatar': MockData.avatar1,
      'image': MockData.imgPho,
      'likes': 12400,
      'comments': 3420,
      'shares': 891,
      'caption': 'Phở Bò Hà Nội buổi sáng - Món ăn quốc hồn quốc túy 🍜 Ai chưa thử thì phải thử ngay! #Pho #Hanoi #StreetFood',
      'music': '🎵 Original Sound - foodie.danang',
    },
    {
      'user': 'travel.huy',
      'avatar': MockData.avatar3,
      'image': MockData.imgSaPa,
      'likes': 8700,
      'comments': 2100,
      'shares': 456,
      'caption': 'Ruộng bậc thang Mù Cang Chải mùa lúa chín 🌾 Đẹp quá trời ơi! #SaPa #TerracedFields #MuCangChai',
      'music': '🎵 Nhạc Tây Bắc - Traditional',
    },
    {
      'user': 'explore.vietnam',
      'avatar': MockData.avatar4,
      'image': MockData.imgHaLongBay,
      'likes': 15600,
      'comments': 4200,
      'shares': 1230,
      'caption': 'Vịnh Hạ Long - Di sản thiên nhiên thế giới 🌊 Đi thuyền ngắm biển thật sự quá tuyệt vời #HaLongBay #UNESCO',
      'music': '🎵 Ocean Waves - Relaxing',
    },
    {
      'user': 'goldenbridge.vn',
      'avatar': MockData.avatar5,
      'image': MockData.imgGoldenBridge,
      'likes': 22100,
      'comments': 5600,
      'shares': 2340,
      'caption': 'Cầu Vàng Bà Nà Hills 🌉 Đôi bàn tay khổng lồ nâng đỡ - biểu tượng của Đà Nẵng #GoldenBridge #BaNaHills #DaNang',
      'music': '🎵 Epic Music - Cinematic',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(count % 1000 == 0 ? 0 : 1)}K';
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Reels PageView
        PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: _reels.length,
          onPageChanged: (index) => setState(() => _currentPage = index),
          itemBuilder: (context, index) {
            final reel = _reels[index];
            return Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(imageUrl: reel['image'], fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter, end: Alignment.bottomCenter,
                      colors: [Colors.black.withValues(alpha: 0.2), Colors.transparent, Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                      stops: const [0.0, 0.2, 0.6, 1.0],
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        // Top bar
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 0, right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Hashtags
                Expanded(
                  child: SizedBox(
                    height: 32,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: MockData.reelsHashtags.length,
                      itemBuilder: (_, i) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: i == 0 ? Colors.white.withValues(alpha: 0.25) : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                          ),
                          child: Center(child: Text(MockData.reelsHashtags[i], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white))),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _showRegionPicker,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.primaryLight.withValues(alpha: 0.85), borderRadius: BorderRadius.circular(16)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(_selectedRegion, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Right Side Actions
        Positioned(
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom + 120,
          child: Column(
            children: [
              // Avatar
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipOval(child: CachedNetworkImage(imageUrl: _reels[_currentPage]['avatar'], fit: BoxFit.cover)),
              ),
              Transform.translate(
                offset: const Offset(0, -8),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  child: const Icon(Icons.add, color: Colors.white, size: 12),
                ),
              ),
              const SizedBox(height: 16),
              _ActionButton(icon: Icons.favorite, count: _formatCount(_reels[_currentPage]['likes']), color: Colors.red),
              const SizedBox(height: 18),
              _ActionButton(icon: Iconsax.message, count: _formatCount(_reels[_currentPage]['comments']), onTap: () => _showComments(context)),
              const SizedBox(height: 18),
              _ActionButton(icon: Iconsax.share, count: _formatCount(_reels[_currentPage]['shares'])),
              const SizedBox(height: 18),
              _ActionButton(icon: Iconsax.archive_add, count: ''),
            ],
          ),
        ),

        // Bottom User Info + Music
        Positioned(
          left: 16, right: 80,
          bottom: MediaQuery.of(context).padding.bottom + 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(_reels[_currentPage]['user'], style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 1.5), borderRadius: BorderRadius.circular(6)),
                  child: Text('Follow', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ]),
              const SizedBox(height: 10),
              Text(_reels[_currentPage]['caption'], maxLines: 3, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 13, color: Colors.white, height: 1.4)),
              const SizedBox(height: 10),
              // Music
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.music_note, color: Colors.white, size: 14),
                  const SizedBox(width: 6),
                  Text(_reels[_currentPage]['music'], style: GoogleFonts.inter(fontSize: 12, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                ]),
              ),
            ],
          ),
        ),

        // Bottom progress indicator
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 70,
          left: 0, right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_reels.length, (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: _currentPage == i ? 20 : 6, height: 3,
              decoration: BoxDecoration(color: _currentPage == i ? Colors.white : Colors.white.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(2)),
            )),
          ),
        ),
      ],
    );
  }

  void _showRegionPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false, initialChildSize: 0.6, maxChildSize: 0.8,
          builder: (context, scrollController) {
            return Column(
              children: [
                const SizedBox(height: 12),
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 16),
                Text('Select Region', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.9, crossAxisSpacing: 10, mainAxisSpacing: 10),
                    itemCount: MockData.regions.length,
                    itemBuilder: (context, index) {
                      final region = MockData.regions[index];
                      final isSelected = _selectedRegion == region['name'];
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedRegion = region['name']!);
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Stack(fit: StackFit.expand, children: [
                              CachedNetworkImage(imageUrl: region['image']!, fit: BoxFit.cover),
                              Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)]))),
                              Positioned(bottom: 8, left: 8, right: 8, child: Text(region['name']!, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white))),
                              if (isSelected) Positioned(top: 6, right: 6, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size: 14))),
                            ]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false, initialChildSize: 0.55, maxChildSize: 0.85,
          builder: (context, scrollController) {
            return Column(
              children: [
                const SizedBox(height: 12),
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(2))),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Comments', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildComment('Thanh Huy', 'Đẹp quá trời luôn bạn ơi! 🔥🔥🔥', MockData.avatar2, '2h', 45),
                      _buildComment('Châu Ngân', 'Cho mình xin location với ạ 📍 Mùa này đẹp ghê', MockData.avatar3, '1h', 23),
                      _buildComment('Minh Quý', 'Lần sau cho mình đi cùng nhaa 😍', MockData.avatar1, '45m', 12),
                      _buildComment('Quỳnh Nguyễn', 'Camera gì vậy bạn? Chụp đẹp quá 📸', MockData.avatar4, '30m', 8),
                      _buildComment('Tuấn Trần', 'Ước gì được đi du lịch suốt 🥺', MockData.avatar5, '15m', 5),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFF1A1A1A), border: Border(top: BorderSide(color: Colors.grey.shade800))),
                  child: Row(children: [
                    CircleAvatar(radius: 16, backgroundImage: const CachedNetworkImageProvider(MockData.userAvatar)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(24)),
                        child: TextField(
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: InputDecoration(hintText: 'Add a comment...', hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14), border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Iconsax.send_1, size: 18, color: Colors.white),
                    ),
                  ]),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildComment(String name, String text, String avatar, String time, int likes) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 18, backgroundImage: CachedNetworkImageProvider(avatar)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                const SizedBox(width: 8),
                Text(time, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey)),
              ]),
              const SizedBox(height: 4),
              Text(text, style: GoogleFonts.inter(fontSize: 14, color: Colors.white.withValues(alpha: 0.85), height: 1.4)),
              const SizedBox(height: 6),
              Row(children: [
                Text('Reply', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                const SizedBox(width: 16),
                Icon(Icons.favorite_border, size: 14, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Text('$likes', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey)),
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String count;
  final Color? color;
  final VoidCallback? onTap;

  const _ActionButton({required this.icon, required this.count, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Icon(icon, color: color ?? Colors.white, size: 28),
        if (count.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(count, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
        ],
      ]),
    );
  }
}
