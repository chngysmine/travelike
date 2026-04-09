import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';

class PhotoGalleryScreen extends StatefulWidget {
  final String title;
  final List<String> images;
  const PhotoGalleryScreen({super.key, required this.title, required this.images});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white)),
                  const SizedBox(width: 12),
                  Text(widget.title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                  const Spacer(),
                  Text('${_selectedIndex + 1}/${widget.images.length}', style: GoogleFonts.inter(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: widget.images.length,
                onPageChanged: (i) => setState(() => _selectedIndex = i),
                itemBuilder: (_, i) => InteractiveViewer(
                  child: Center(child: CachedNetworkImage(imageUrl: widget.images[i], fit: BoxFit.contain)),
                ),
              ),
            ),
            // Thumbnails
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: widget.images.length,
                itemBuilder: (_, i) {
                  final isSelected = _selectedIndex == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      width: 56, height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 2),
                      ),
                      child: ClipRRect(borderRadius: BorderRadius.circular(8), child: CachedNetworkImage(imageUrl: widget.images[i], fit: BoxFit.cover)),
                    ),
                  );
                },
              ),
            ),
            // Actions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _GalleryAction(icon: Iconsax.heart, label: 'Like'),
                _GalleryAction(icon: Iconsax.share, label: 'Share'),
                _GalleryAction(icon: Iconsax.archive_add, label: 'Save'),
                _GalleryAction(icon: Iconsax.message, label: 'Comment'),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _GalleryAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(icon, color: Colors.white, size: 22),
      const SizedBox(height: 4),
      Text(label, style: GoogleFonts.inter(fontSize: 11, color: Colors.white70)),
    ]);
  }
}
