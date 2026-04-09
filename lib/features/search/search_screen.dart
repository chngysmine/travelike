import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../core/utils/page_transitions.dart';
import '../attractions/attraction_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';
  final _controller = TextEditingController();
  final _focuses = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focuses.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focuses.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredDestinations {
    if (_query.isEmpty) return MockData.destinations;
    return MockData.destinations.where((d) => (d['name'] as String).toLowerCase().contains(_query.toLowerCase()) || (d['location'] as String).toLowerCase().contains(_query.toLowerCase())).toList();
  }

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
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)]),
                        child: TextField(
                          controller: _controller,
                          focusNode: _focuses,
                          onChanged: (v) => setState(() => _query = v),
                          decoration: InputDecoration(
                            icon: const Icon(Iconsax.search_normal, size: 20, color: AppColors.textTertiary),
                            hintText: 'Search destinations, food, events...',
                            hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.textTertiary),
                            border: InputBorder.none,
                            suffixIcon: _query.isNotEmpty ? IconButton(icon: const Icon(Icons.close, size: 18), onPressed: () => setState(() { _controller.clear(); _query = ''; })) : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 300.ms),
              // Recent / Popular
              if (_query.isEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Popular Searches', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(spacing: 8, runSpacing: 8, children: ['Hội An', 'Phở', 'Beach', 'Đà Nẵng', 'Golden Bridge', 'Sa Pa', 'Street Food'].map((tag) => GestureDetector(
                    onTap: () => setState(() { _query = tag; _controller.text = tag; }),
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(20)), child: Text(tag, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primary))),
                  )).toList()),
                ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Trending Destinations', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ],
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _filteredDestinations.length,
                  itemBuilder: (context, index) {
                    final dest = _filteredDestinations[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, PageTransitions.fadeScale(AttractionDetailScreen(destination: dest))),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)]),
                        child: Row(children: [
                          ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(imageUrl: dest['image'], width: 70, height: 70, fit: BoxFit.cover)),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(dest['name'], style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Row(children: [
                              const Icon(Iconsax.location, size: 14, color: AppColors.textTertiary),
                              const SizedBox(width: 4),
                              Text(dest['location'], style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                            ]),
                          ])),
                          Column(children: [
                            Row(children: [const Icon(Icons.star_rounded, size: 14, color: AppColors.accentGold), Text(' ${dest['rating']}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600))]),
                          ]),
                        ]),
                      ),
                    ).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms);
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
