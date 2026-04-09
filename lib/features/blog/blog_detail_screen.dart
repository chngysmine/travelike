import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';

class BlogDetailScreen extends StatelessWidget {
  final Map<String, dynamic> blog;
  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 300, width: double.infinity, child: CachedNetworkImage(imageUrl: blog['image'], fit: BoxFit.cover)),
                Container(
                  transform: Matrix4.translationValues(0, -28, 0),
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tags
                      if (blog['tags'] != null) Wrap(
                        spacing: 8, runSpacing: 8,
                        children: (blog['tags'] as List<String>).map((tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(8)),
                          child: Text('#$tag', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primary)),
                        )).toList(),
                      ).animate().fadeIn(duration: 400.ms),
                      const SizedBox(height: 16),
                      Text(blog['title'], style: GoogleFonts.playfairDisplay(fontSize: 26, fontWeight: FontWeight.w700, height: 1.3)).animate().fadeIn(duration: 400.ms, delay: 100.ms),
                      const SizedBox(height: 16),
                      // Author
                      Row(children: [
                        CircleAvatar(radius: 20, backgroundImage: CachedNetworkImageProvider(blog['authorAvatar'])),
                        const SizedBox(width: 12),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(blog['author'], style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                          Text(blog['date'], style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                        ]),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
                          child: Text('Follow', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                        ),
                      ]).animate().fadeIn(duration: 400.ms, delay: 200.ms),
                      const SizedBox(height: 24),
                      Text(blog['content'], style: GoogleFonts.inter(fontSize: 15, color: AppColors.textSecondary, height: 1.8)).animate().fadeIn(duration: 400.ms, delay: 300.ms),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      // Stats
                      Row(children: [
                        const Icon(Icons.favorite, size: 20, color: Colors.red),
                        const SizedBox(width: 6),
                        Text('${blog['likes']}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 24),
                        Icon(Iconsax.message, size: 20, color: AppColors.textTertiary),
                        const SizedBox(width: 6),
                        Text('${blog['comments']}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 24),
                        Icon(Iconsax.share, size: 20, color: AppColors.textTertiary),
                        const SizedBox(width: 6),
                        Text('${blog['shares'] ?? 0}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        Icon(Iconsax.archive_add, size: 22, color: AppColors.textTertiary),
                      ]),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8, left: 16, right: 16,
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.arrow_back_ios_new, size: 18))),
              const Spacer(),
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.more_horiz, size: 20)),
            ]),
          ),
        ],
      ),
    );
  }
}
