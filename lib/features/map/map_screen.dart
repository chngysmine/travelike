import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/app_back_button.dart';

class MapScreen extends StatefulWidget {
  final String title;

  const MapScreen({super.key, this.title = 'Explore Map'});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // A mock map background using an aerial/map view from Unsplash
  final String mapImageUrl = 'https://images.unsplash.com/photo-1524661135-423995f22d0b?q=80&w=1200&auto=format&fit=crop';
  
  // Simulated map markers
  final List<Offset> _markers = [
    const Offset(150, 300),
    const Offset(250, 400),
    const Offset(300, 200),
    const Offset(100, 500),
    const Offset(200, 350),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          // ==================== INTERACTIVE MAP LAYER ====================
          InteractiveViewer(
            minScale: 0.5,
            maxScale: 3.0,
            boundaryMargin: const EdgeInsets.all(500),
            child: Stack(
              children: [
                // Base Map Image
                SizedBox(
                  width: 2000,
                  height: 2000,
                  child: CachedNetworkImage(
                    imageUrl: mapImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                
                // Map Markers
                ..._markers.map((offset) => Positioned(
                  left: offset.dx,
                  top: offset.dy,
                  child: const _MapMarker(),
                )),
              ],
            ),
          ),
          
          // ==================== HEADER ====================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const AppBackButton(),
                  AppSpacing.hMd,
                  Expanded(
                    child: GlassContainer.light(
                      borderRadius: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Iconsax.search_normal, size: 20, color: AppColors.textPrimary),
                          AppSpacing.hSm,
                          Text(
                            widget.title,
                            style: AppTextStyles.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==================== BOTTOM HIGHLIGHT CARD ====================
          Positioned(
            left: 20,
            right: 20,
            bottom: 40,
            child: GlassContainer.light(
              borderRadius: 24,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: 'https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=200&auto=format&fit=crop',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  AppSpacing.hMd,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nearby Attraction', style: AppTextStyles.labelMedium.secondary),
                        AppSpacing.vXs,
                        Text('Golden Bridge Peak', style: AppTextStyles.titleMedium),
                        AppSpacing.vXs,
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.orange, size: 16),
                            Text(' 4.8 ', style: AppTextStyles.labelMedium),
                            Text('(1.2k reviews)', style: AppTextStyles.labelMedium.secondary),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.route_square, color: AppColors.primary),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primarySurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapMarker extends StatelessWidget {
  const _MapMarker();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Iconsax.location, color: Colors.white, size: 20),
        ),
        Container(
          width: 2,
          height: 12,
          color: AppColors.primary,
        ),
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
