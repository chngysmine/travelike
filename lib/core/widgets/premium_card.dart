import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

class PremiumCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double rating;
  final String? badgeText;
  final double? price;
  final VoidCallback onTap;
  final VoidCallback? onBookmarkTap;
  final bool isBookmarked;
  final double height;
  final double width;

  const PremiumCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.onTap,
    this.badgeText,
    this.price,
    this.onBookmarkTap,
    this.isBookmarked = false,
    this.height = 240,
    this.width = double.infinity,
  });

  /// Factory style for Destinations
  factory PremiumCard.destination({
    required Map<String, dynamic> data,
    required VoidCallback onTap,
    VoidCallback? onBookmarkTap,
    bool isBookmarked = false,
  }) {
    return PremiumCard(
      imageUrl: data['image'],
      title: data['name'],
      subtitle: data['location'],
      rating: (data['rating'] as num).toDouble(),
      price: data['price'] != null ? (data['price'] as num).toDouble() : null,
      onTap: onTap,
      onBookmarkTap: onBookmarkTap,
      isBookmarked: isBookmarked,
    );
  }

  /// Factory style for Events
  factory PremiumCard.event({
    required Map<String, dynamic> data,
    required VoidCallback onTap,
    VoidCallback? onBookmarkTap,
    bool isBookmarked = false,
  }) {
    return PremiumCard(
      imageUrl: data['image'],
      title: data['title'] ?? data['name'] ?? 'Event',
      subtitle: '${data['date']} • ${data['location']}',
      badgeText: data['category'],
      rating: 5.0, // Default or fetch from data
      price: data['price'] != null ? (data['price'] as num).toDouble() : null,
      onTap: onTap,
      onBookmarkTap: onBookmarkTap,
      isBookmarked: isBookmarked,
      height: 260,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: AppSpacing.borderXxl,
          boxShadow: AppColors.cardShadow,
        ),
        child: ClipRRect(
          borderRadius: AppSpacing.borderXxl,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ==================== IMAGE ====================
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.primarySurface,
                ),
              ),

              // ==================== GRADIENT OVERLAY ====================
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.cardGradient,
                ),
              ),

              // ==================== TOP ELEMENTS ====================
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Badge Text
                    if (badgeText != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.9),
                          borderRadius: AppSpacing.borderSm,
                        ),
                        child: Text(
                          badgeText!,
                          style: AppTextStyles.badge,
                        ),
                      )
                    else
                      const SizedBox.shrink(),

                    // Bookmark
                    if (onBookmarkTap != null || isBookmarked)
                      GestureDetector(
                        onTap: onBookmarkTap,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isBookmarked ? Icons.favorite_rounded : Iconsax.heart,
                            color: isBookmarked ? AppColors.chipRed : AppColors.textPrimary,
                            size: 18,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // ==================== BOTTOM DATA ====================
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleLarge.white,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppSpacing.vSm,
                    Row(
                      children: [
                        const Icon(Iconsax.location, color: Colors.white70, size: 14),
                        AppSpacing.hLg, // Used as dynamic space
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            subtitle,
                            style: AppTextStyles.bodySmall.white70,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.vLg,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rating
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: AppColors.accentGold, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              rating.toStringAsFixed(1),
                              style: AppTextStyles.labelLarge.white,
                            ),
                          ],
                        ),
                        // Price
                        if (price != null && price! > 0)
                          Text(
                            '\$${price!.toStringAsFixed(0)}',
                            style: AppTextStyles.titleLarge.white,
                          )
                        else if (price == 0)
                          Text(
                            'FREE',
                            style: AppTextStyles.labelLarge.copyWith(color: AppColors.chipGreen),
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
  }
}
