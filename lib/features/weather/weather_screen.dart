import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = MockData.weather;
    final forecast = weather['forecast'] as List<Map<String, dynamic>>;
    final hourly = weather['hourly'] as List<Map<String, dynamic>>;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Header
            Row(
              children: [
                Text('Weather', style: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                  child: Row(children: [
                    const Icon(Icons.location_on, size: 16, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(weather['city'] as String, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                    const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textTertiary),
                  ]),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms),

            const SizedBox(height: 24),

            // Main weather card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [BoxShadow(color: const Color(0xFF667eea).withValues(alpha: 0.4), blurRadius: 24, offset: const Offset(0, 12))],
              ),
              child: Column(children: [
                Text(weather['icon'] as String, style: const TextStyle(fontSize: 64)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${weather['temp']}', style: GoogleFonts.inter(fontSize: 64, fontWeight: FontWeight.w200, color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text('°C', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w300, color: Colors.white.withValues(alpha: 0.7))),
                    ),
                  ],
                ),
                Text(weather['condition'] as String, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white.withValues(alpha: 0.8))),
                Text('Feels like ${weather['feelsLike']}°C', style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withValues(alpha: 0.6))),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _WeatherDetail(icon: '💧', label: 'Humidity', value: '${weather['humidity']}%'),
                    _WeatherDetail(icon: '💨', label: 'Wind', value: '${weather['wind']} km/h'),
                    _WeatherDetail(icon: '☀️', label: 'UV Index', value: '${weather['uv']}'),
                    _WeatherDetail(icon: '👁️', label: 'Visibility', value: '${weather['visibility']} km'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('🌅 ${weather['sunrise']}', style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.7))),
                  const SizedBox(width: 24),
                  Text('🌇 ${weather['sunset']}', style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.7))),
                ]),
              ]),
            ).animate().fadeIn(duration: 500.ms, delay: 100.ms).slideY(begin: 0.1, end: 0),

            const SizedBox(height: 24),

            // Hourly Forecast
            Align(alignment: Alignment.centerLeft, child: Text('Hourly Forecast', style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
            const SizedBox(height: 12),
            SizedBox(
              height: 105,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hourly.length,
                itemBuilder: (_, index) {
                  final h = hourly[index];
                  final isNow = index == 0;
                  return Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isNow ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(h['time'] as String, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: isNow ? Colors.white : AppColors.textTertiary)),
                      const SizedBox(height: 8),
                      Text(h['icon'] as String, style: const TextStyle(fontSize: 24)),
                      const SizedBox(height: 8),
                      Text('${h['temp']}°', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: isNow ? Colors.white : AppColors.textPrimary)),
                    ]),
                  );
                },
              ),
            ).animate().fadeIn(duration: 400.ms, delay: 200.ms),

            const SizedBox(height: 24),

            // 7-day forecast
            Align(alignment: Alignment.centerLeft, child: Text('7-Day Forecast', style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12)]),
              child: Column(
                children: forecast.asMap().entries.map((entry) {
                  final day = entry.value;
                  final isToday = entry.key == 0;
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(border: entry.key < forecast.length - 1 ? Border(bottom: BorderSide(color: Colors.grey.shade100)) : null),
                    child: Row(children: [
                      SizedBox(width: 50, child: Text(isToday ? 'Today' : day['day'] as String, style: GoogleFonts.inter(fontSize: 14, fontWeight: isToday ? FontWeight.w600 : FontWeight.w400, color: isToday ? AppColors.primary : AppColors.textPrimary))),
                      const Spacer(),
                      Text(day['icon'] as String, style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 8),
                      SizedBox(width: 60, child: Text(day['condition'] as String, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary))),
                      const SizedBox(width: 12),
                      Text('${day['low']}° / ', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textTertiary)),
                      Text('${day['temp']}°', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    ]),
                  );
                }).toList(),
              ),
            ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

            const SizedBox(height: 24),

            // Travel tip
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppColors.primarySurface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.primary.withValues(alpha: 0.2))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const Text('💡', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text('Travel Tip', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary)),
                ]),
                const SizedBox(height: 8),
                Text(
                  'Great weather for exploring! Don\'t forget sunscreen and stay hydrated. Best time to visit Ba Na Hills is in the morning when it\'s cooler and less crowded.',
                  style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
                ),
              ]),
            ).animate().fadeIn(duration: 500.ms, delay: 400.ms),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const _WeatherDetail({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(icon, style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 4),
      Text(value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
      Text(label, style: GoogleFonts.inter(fontSize: 11, color: Colors.white70)),
    ]);
  }
}
