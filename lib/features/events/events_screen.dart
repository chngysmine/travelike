import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import '../payment/payment_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  bool _showUpcoming = true;
  int _selectedCategory = 0;

  List<Map<String, dynamic>> get _filteredEvents {
    if (_selectedCategory == 0) return MockData.events;
    return MockData.events.where((e) => e['category'] == MockData.eventCategories[_selectedCategory]).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20)),
                  const SizedBox(width: 12),
                  Text('Events', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)]),
                    child: const Icon(Iconsax.search_normal, size: 20, color: AppColors.textSecondary),
                  ),
                ]),
              ).animate().fadeIn(duration: 400.ms),

              // Toggle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  child: Row(children: [
                    Expanded(child: GestureDetector(
                      onTap: () => setState(() => _showUpcoming = true),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(color: _showUpcoming ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text('Upcoming', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: _showUpcoming ? Colors.white : AppColors.textSecondary))),
                      ),
                    )),
                    Expanded(child: GestureDetector(
                      onTap: () => setState(() => _showUpcoming = false),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(color: !_showUpcoming ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text('Past events', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: !_showUpcoming ? Colors.white : AppColors.textSecondary))),
                      ),
                    )),
                  ]),
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

              const SizedBox(height: 12),

              // Category chips
              SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: MockData.eventCategories.length,
                  itemBuilder: (_, index) {
                    final isSelected = _selectedCategory == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCategory = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary.withValues(alpha: 0.15) : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isSelected ? AppColors.primary : Colors.grey.shade300),
                        ),
                        child: Center(child: Text(MockData.eventCategories[index], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: isSelected ? AppColors.primary : AppColors.textTertiary))),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _filteredEvents.length,
                  itemBuilder: (context, index) {
                    final event = _filteredEvents[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(context, PageTransitions.fadeScale(_EventDetailScreen(event: event))),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))]),
                        child: Row(children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                            child: CachedNetworkImage(imageUrl: event['image'], width: 100, height: 110, fit: BoxFit.cover),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(children: [
                                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(6)), child: Text(event['category'] ?? '', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary))),
                                  const Spacer(),
                                  if (event['price'] == 0) Text('FREE', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.chipGreen))
                                  else Text('\$${event['price']}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                                ]),
                                const SizedBox(height: 6),
                                Text(event['title'], maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 6),
                                Row(children: [
                                  const Icon(Iconsax.calendar_1, size: 12, color: AppColors.textTertiary),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text(event['date'], style: GoogleFonts.inter(fontSize: 11, color: AppColors.textTertiary))),
                                ]),
                                const SizedBox(height: 4),
                                Row(children: [
                                  const Icon(Iconsax.location, size: 12, color: AppColors.textTertiary),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text(event['location'], maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textTertiary))),
                                ]),
                              ]),
                            ),
                          ),
                        ]),
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: (index * 80).ms).slideX(begin: 0.03, end: 0);
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

class _EventDetailScreen extends StatelessWidget {
  final Map<String, dynamic> event;
  const _EventDetailScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 320, width: double.infinity, child: Stack(fit: StackFit.expand, children: [
                CachedNetworkImage(imageUrl: event['image'], fit: BoxFit.cover),
                const DecoratedBox(decoration: BoxDecoration(gradient: AppColors.cardGradient)),
              ])),
              Container(
                transform: Matrix4.translationValues(0, -28, 0),
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
                padding: const EdgeInsets.all(24),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(event['title'], style: GoogleFonts.playfairDisplay(fontSize: 26, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  _DetailRow(icon: Iconsax.calendar_1, title: event['date'], subtitle: event['time']),
                  const SizedBox(height: 12),
                  _DetailRow(icon: Iconsax.location, title: event['location'], subtitle: event['address']),
                  const SizedBox(height: 20),
                  Row(children: [
                    CircleAvatar(radius: 22, backgroundImage: CachedNetworkImageProvider(event['organizerAvatar'])),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(event['organizer'], style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                      Text('Organizer', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                    ])),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(8)),
                      child: Text('Follow', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Text('About Event', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(event['description'], style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary, height: 1.7)),
                  const SizedBox(height: 16),
                  Row(children: [
                    const Icon(Iconsax.people, size: 18, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text('${event['going']}+ Going', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  ]),
                  const SizedBox(height: 100),
                ]),
              ),
            ]),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8, left: 16, right: 16,
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.arrow_back_ios_new, size: 18))),
              const Spacer(),
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(14)), child: const Icon(Iconsax.archive_add, size: 20)),
            ]),
          ),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, -4))]),
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Price', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                  Text(event['price'] == 0 ? 'Free' : '\$${event['price']}', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ]),
                const Spacer(),
                SizedBox(height: 52, child: ElevatedButton(
                  onPressed: () => Navigator.push(context, PageTransitions.slideUp(const PaymentScreen())),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), padding: const EdgeInsets.symmetric(horizontal: 32)),
                  child: Text('Buy Ticket', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _DetailRow({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, size: 22, color: AppColors.primary),
      ),
      const SizedBox(width: 14),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
        Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
      ])),
    ]);
  }
}
