import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import 'blog_detail_screen.dart';

class BlogListScreen extends StatelessWidget {
  const BlogListScreen({super.key});

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
                    Text('New Blog', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Iconsax.edit, size: 18, color: Colors.white),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: MockData.blogPosts.length,
                  itemBuilder: (context, index) {
                    final blog = MockData.blogPosts[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, PageTransitions.fadeScale(BlogDetailScreen(blog: blog))),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                              child: CachedNetworkImage(imageUrl: blog['image'], height: 180, width: double.infinity, fit: BoxFit.cover),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    CircleAvatar(radius: 16, backgroundImage: CachedNetworkImageProvider(blog['authorAvatar'])),
                                    const SizedBox(width: 8),
                                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(blog['author'], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                                      Text(blog['date'], style: GoogleFonts.inter(fontSize: 11, color: AppColors.textTertiary)),
                                    ])),
                                    const Icon(Icons.more_horiz, color: AppColors.textTertiary),
                                  ]),
                                  const SizedBox(height: 12),
                                  Text(blog['title'], style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 8),
                                  Text(blog['content'], maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                                  const SizedBox(height: 12),
                                  // Tags
                                  if (blog['tags'] != null) Wrap(
                                    spacing: 6,
                                    children: (blog['tags'] as List<String>).take(3).map((tag) => Text('#$tag', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primary))).toList(),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(children: [
                                    const Icon(Icons.favorite, size: 18, color: Colors.red),
                                    const SizedBox(width: 6),
                                    Text('${blog['likes']}', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                                    const SizedBox(width: 20),
                                    Icon(Iconsax.message, size: 18, color: AppColors.textTertiary),
                                    const SizedBox(width: 6),
                                    Text('${blog['comments']}', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                                    const Spacer(),
                                    Icon(Iconsax.archive_add, size: 18, color: AppColors.textTertiary),
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: 500.ms, delay: (index * 100).ms).slideY(begin: 0.03, end: 0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
