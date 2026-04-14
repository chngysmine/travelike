import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/app_back_button.dart';
import '../../core/utils/app_animations.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8B4049), Color(0xFFC4776E), Color(0xFFFFF0ED)],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ==================== APP BAR ====================
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBackButton.onImage(),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => const _LocationPickerSheet(),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              'Hanoi, Vietnam',
                              style: AppTextStyles.titleLarge.white,
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 24),
                          ],
                        ),
                      ).fadeInUp(),
                      AppActionButton(icon: Iconsax.search_normal, isOnImage: true, onTap: () {}),
                    ],
                  ),
                ),
              ),

              // ==================== MAIN WEATHER CARD ====================
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenH,
                  child: GlassContainer.dark(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.cloud_sunny, size: 80, color: Colors.white).fadeInScale(),
                        AppSpacing.vLg,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('26', style: AppTextStyles.hero.copyWith(fontSize: 84, color: Colors.white)),
                            Text('°C', style: AppTextStyles.displayMedium.white),
                          ],
                        ).fadeInUp(delay: 100.ms),
                        AppSpacing.vSm,
                        Text('Partly Cloudy', style: AppTextStyles.titleLarge.white).fadeInUp(delay: 150.ms),
                        AppSpacing.vLg,
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: AppSpacing.borderRound,
                          ),
                          child: Text(
                            'H: 29°  L: 22°',
                            style: AppTextStyles.labelLarge.white,
                          ),
                        ).fadeInUp(delay: 200.ms),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: AppSpacing.vXxl),

              // ==================== METRICS GRID ====================
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenH,
                  child: Row(
                    children: [
                      Expanded(
                        child: _MetricCard(
                          icon: Iconsax.drop,
                          title: 'Humidity',
                          value: '68%',
                          delay: 250,
                        ),
                      ),
                      AppSpacing.hMd,
                      Expanded(
                        child: _MetricCard(
                          icon: Iconsax.wind,
                          title: 'Wind',
                          value: '12 km/h',
                          delay: 300,
                        ),
                      ),
                      AppSpacing.hMd,
                      Expanded(
                        child: _MetricCard(
                          icon: Iconsax.sun_1,
                          title: 'UV Index',
                          value: 'High (6)',
                          delay: 350,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: AppSpacing.vXxl),

              // ==================== HOURLY FORECAST ====================
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.screenH,
                  child: Text('Today', style: AppTextStyles.displaySmall.white).fadeInUp(delay: 400.ms),
                ),
              ),

              SliverToBoxAdapter(child: AppSpacing.vMd),

              SliverToBoxAdapter(
                child: SizedBox(
                   height: 120,
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     padding: AppSpacing.screenH,
                     physics: const BouncingScrollPhysics(),
                     itemCount: 8,
                     itemBuilder: (context, index) {
                       final hours = ['Now', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00'];
                       final temps = ['26°', '27°', '28°', '27°', '26°', '25°', '23°', '22°'];
                       final icons = [Iconsax.cloud_sunny, Iconsax.sun_1, Iconsax.sun_1, Iconsax.cloud_sunny, Iconsax.cloud, Icons.cloud_queue_rounded, Icons.nights_stay_rounded, Icons.nights_stay_rounded];
                       
                       return Container(
                         width: 76,
                         margin: const EdgeInsets.only(right: 12),
                         child: GlassContainer(
                           blur: index == 0 ? 0 : AppColors.glassBlurMedium, // Solid color for 'Now'
                           backgroundColor: index == 0 ? Colors.white : Colors.white.withValues(alpha: 0.1),
                           borderColor: index == 0 ? null : Colors.white.withValues(alpha: 0.2),
                           borderRadius: 24,
                           padding: const EdgeInsets.symmetric(vertical: 16),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 hours[index],
                                 style: AppTextStyles.labelMedium.copyWith(
                                   color: index == 0 ? AppColors.primary : Colors.white,
                                 ),
                               ),
                               Icon(
                                 icons[index],
                                 color: index == 0 ? AppColors.accentGold : Colors.white,
                                 size: 24,
                               ),
                               Text(
                                 temps[index],
                                 style: AppTextStyles.titleMedium.copyWith(
                                   color: index == 0 ? AppColors.textPrimary : Colors.white,
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ).fadeInLeft(index: index);
                     },
                   ),
                ),
              ),

              SliverToBoxAdapter(child: AppSpacing.vXxl),

              // ==================== 5-DAY ALMANAC ====================
              SliverToBoxAdapter(
                child: Container(
                  margin: AppSpacing.screenH,
                  child: GlassContainer.dark(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Iconsax.calendar_1, color: Colors.white70, size: 20),
                            AppSpacing.hSm,
                            Text('5-DAY FORECAST', style: AppTextStyles.labelMedium.white70),
                          ],
                        ),
                        AppSpacing.vLg,
                        const Divider(color: Colors.white24, height: 1),
                        ...List.generate(5, (index) {
                          final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
                          final icons = [Iconsax.cloud_sunny, Icons.cloud_queue_rounded, Iconsax.flash, Iconsax.cloud_drizzle, Iconsax.sun_1];
                          final highs = [29, 27, 24, 25, 30];
                          final lows = [22, 21, 20, 20, 23];
                          
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                SizedBox(width: 40, child: Text(days[index], style: AppTextStyles.titleMedium.white)),
                                AppSpacing.hLg,
                                Icon(icons[index], color: Colors.white, size: 24),
                                AppSpacing.hLg,
                                Text('${lows[index]}°', style: AppTextStyles.titleMedium.white70),
                                AppSpacing.hSm,
                                Expanded(
                                  child: Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: (highs[index] - lows[index]) / 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [Colors.blue.shade300, AppColors.accentGold]),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                AppSpacing.hSm,
                                Text('${highs[index]}°', style: AppTextStyles.titleMedium.white),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ).fadeInUp(delay: 500.ms),
              ),

              // Bottom safe space
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final int delay;

  const _MetricCard({required this.icon, required this.title, required this.value, required this.delay});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      backgroundColor: Colors.white.withValues(alpha: 0.1),
      borderColor: Colors.white.withValues(alpha: 0.2),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          AppSpacing.vLg,
          Text(title, style: AppTextStyles.labelSmall.white70),
          AppSpacing.vXs,
          Text(value, style: AppTextStyles.titleMedium.white),
        ],
      ),
    ).fadeInUp(delay: Duration(milliseconds: delay));
  }
}

class _LocationPickerSheet extends StatelessWidget {
  const _LocationPickerSheet();

  @override
  Widget build(BuildContext context) {
    final cities = ['Hanoi, Vietnam', 'Ho Chi Minh City, Vietnam', 'Da Nang, Vietnam', 'Da Lat, Vietnam', 'Sapa, Vietnam'];
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: cities.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            leading: const Icon(Iconsax.location, color: AppColors.primary),
            title: Text(cities[index], style: AppTextStyles.titleMedium),
            onTap: () {
              // Simulated location change logic
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}

