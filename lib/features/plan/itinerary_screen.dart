import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  int _selectedDay = 1;
  int _selectedChip = 0;

  final List<String> _chips = ['Island', 'Beach', 'Resort'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                    const Spacer(),
                    Text('Itinerary Form', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    const Icon(Iconsax.clipboard_export, size: 22),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),

              // Chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: _chips.asMap().entries.map((entry) {
                    final isSelected = _selectedChip == entry.key;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedChip = entry.key),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : Colors.grey.shade300,
                            ),
                          ),
                          child: Text(
                            entry.value,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

              const SizedBox(height: 20),

              // Day tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [1, 2, 3].map((day) {
                    final isSelected = _selectedDay == day;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedDay = day),
                        child: Column(
                          children: [
                            Text(
                              'Day $day',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                                color: isSelected ? AppColors.textPrimary : AppColors.textTertiary,
                              ),
                            ),
                            Text(
                              'July ${13 + day}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: isSelected ? AppColors.primary : AppColors.textTertiary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (isSelected)
                              Container(height: 3, width: 60, decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(2),
                              )),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 200.ms),

              const SizedBox(height: 24),

              // Timeline
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: MockData.itinerary.length,
                  itemBuilder: (context, index) {
                    final item = MockData.itinerary[index];
                    final isLast = index == MockData.itinerary.length - 1;
                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Time
                          SizedBox(
                            width: 50,
                            child: Text(
                              item['time'],
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: item['isActive'] ? AppColors.primary : AppColors.textSecondary,
                              ),
                            ),
                          ),
                          // Timeline dot + line
                          Column(
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: item['isActive'] ? AppColors.primary : Colors.grey.shade300,
                                  border: item['isActive']
                                      ? Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 4)
                                      : null,
                                ),
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    color: index == 0 ? AppColors.primaryLight : Colors.grey.shade300,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          // Content
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 24),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item['subtitle'],
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            color: AppColors.textTertiary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(item['icon'], style: const TextStyle(fontSize: 32)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: (index * 100).ms);
                  },
                ),
              ),

              // CTA
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text('View specific itinerary', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
