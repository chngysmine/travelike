import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/app_back_button.dart';
import '../../core/utils/app_animations.dart';
import '../../core/utils/page_transitions.dart';
import '../payment/payment_screen.dart';

class BookFlightScreen extends StatefulWidget {
  const BookFlightScreen({super.key});

  @override
  State<BookFlightScreen> createState() => _BookFlightScreenState();
}

class _BookFlightScreenState extends State<BookFlightScreen> {
  int _selectedTripType = 0; // 0: One Way, 1: Round Trip

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leading: const Padding(
           padding: EdgeInsets.only(left: 10),
           child: AppBackButton(),
        ),
        title: Text('Search Flights', style: AppTextStyles.displayMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: AppSpacing.screen,
        child: Column(
          children: [
            // ==================== TRIP TYPE TOGGLE ====================
            GlassContainer.solid(
              height: 48,
              borderRadius: 24,
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  _TripToggle(
                    title: 'One Way',
                    isSelected: _selectedTripType == 0,
                    onTap: () => setState(() => _selectedTripType = 0),
                  ),
                  _TripToggle(
                    title: 'Round Trip',
                    isSelected: _selectedTripType == 1,
                    onTap: () => setState(() => _selectedTripType = 1),
                  ),
                ],
              ),
            ).fadeInUp(),

            AppSpacing.vXxl,

            // ==================== LOCATION & DATE FORM ====================
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              child: Column(
                children: [
                  // From / To input fields
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Column(
                        children: [
                          _FlightInput(
                            label: 'From',
                            value: 'Hanoi (HAN)',
                            icon: Iconsax.airplane,
                            iconColor: AppColors.textTertiary,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Divider(color: Colors.grey.withValues(alpha: 0.1)),
                          ),
                          _FlightInput(
                            label: 'To',
                            value: 'Da Nang (DAD)',
                            icon: Iconsax.location,
                            iconColor: AppColors.primary,
                          ),
                        ],
                      ),
                      // Floating swap button
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                          boxShadow: AppSpacing.shadowSm,
                        ),
                        child: const Icon(Icons.swap_vert_rounded, color: AppColors.primary, size: 20),
                      ),
                    ],
                  ),
                  
                  AppSpacing.vLg,
                  
                  // Date selection
                  Row(
                    children: [
                      Expanded(
                        child: _FlightInput(
                          label: 'Departure',
                          value: 'Sat, 14 Oct',
                          icon: Iconsax.calendar_1,
                          iconColor: AppColors.textTertiary,
                        ),
                      ),
                      if (_selectedTripType == 1) ...[
                        AppSpacing.hLg,
                        Expanded(
                          child: _FlightInput(
                            label: 'Return',
                            value: 'Sat, 21 Oct',
                            icon: Iconsax.calendar_1,
                            iconColor: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),

                  AppSpacing.vLg,

                  // Passengers & Class
                  Row(
                    children: [
                      Expanded(
                        child: _FlightInput(
                          label: 'Travelers',
                          value: '1 Adult',
                          icon: Iconsax.user,
                          iconColor: AppColors.textTertiary,
                        ),
                      ),
                      AppSpacing.hLg,
                      Expanded(
                        child: _FlightInput(
                          label: 'Class',
                          value: 'Economy',
                          icon: Iconsax.star_1,
                          iconColor: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  
                  AppSpacing.vXxl,

                  // Search Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Demo search result reveal
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Searching flights...', style: AppTextStyles.labelMedium.white)),
                        );
                      },
                      child: const Text('Search Flights'),
                    ),
                  ),
                ],
              ),
            ).fadeInUp(delay: 50.ms),

            AppSpacing.vXxl,

            // ==================== FLIGHT RESULTS ====================
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Available Flights', style: AppTextStyles.displaySmall).fadeInUp(delay: 100.ms),
            ),
            AppSpacing.vLg,

            _FlightCard(
              airline: 'Vietnam Airlines',
              flightNumber: 'VN-123',
              departureTime: '08:00 AM',
              arrivalTime: '09:20 AM',
              duration: '1h 20m',
              price: 120,
              delay: 150,
              onTap: () => Navigator.push(context, PageTransitions.slideRight(const PaymentScreen())),
            ),
            _FlightCard(
              airline: 'Bamboo Airways',
              flightNumber: 'QH-456',
              departureTime: '10:30 AM',
              arrivalTime: '11:45 AM',
              duration: '1h 15m',
              price: 105,
              delay: 200,
              onTap: () => Navigator.push(context, PageTransitions.slideRight(const PaymentScreen())),
            ),
            _FlightCard(
              airline: 'Vietjet Air',
              flightNumber: 'VJ-789',
              departureTime: '02:00 PM',
              arrivalTime: '03:30 PM',
              duration: '1h 30m',
              price: 85,
              delay: 250,
              onTap: () => Navigator.push(context, PageTransitions.slideRight(const PaymentScreen())),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _TripToggle extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TripToggle({required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppAnimations.fast,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: AppSpacing.borderRound,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTextStyles.labelMedium.copyWith(
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _FlightInput extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _FlightInput({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelSmall.secondary),
        AppSpacing.vXs,
        Row(
          children: [
            Icon(icon, size: 20, color: iconColor),
            AppSpacing.hSm,
            Expanded(
              child: Text(value, style: AppTextStyles.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ],
        )
      ],
    );
  }
}

class _FlightCard extends StatelessWidget {
  final String airline;
  final String flightNumber;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final double price;
  final int delay;
  final VoidCallback onTap;

  const _FlightCard({
    required this.airline,
    required this.flightNumber,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.delay,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: AppSpacing.card,
        borderRadius: 20,
        child: Column(
          children: [
            Row(
              children: [
                _buildAirlineLogo(airline),
                AppSpacing.hMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(airline, style: AppTextStyles.titleMedium),
                      Text(flightNumber, style: AppTextStyles.labelSmall.secondary),
                    ],
                  ),
                ),
                Text('\$${price.toStringAsFixed(0)}', style: AppTextStyles.price),
              ],
            ),
            AppSpacing.vXxl,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _TimeBlock(time: departureTime, place: 'HAN'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(duration, style: AppTextStyles.labelSmall.secondary),
                        AppSpacing.vXs,
                        Row(
                          children: [
                            const Icon(Icons.circle_outlined, size: 8, color: AppColors.primary),
                            Expanded(
                              child: Container(
                                height: 1.5,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.textTertiary.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              ),
                            ),
                            Transform.rotate(
                              angle: 1.57, // 90 degrees
                              child: const Icon(Icons.flight_rounded, size: 16, color: AppColors.primary),
                            ),
                          ],
                        ),
                        AppSpacing.vXs,
                        Text('Direct', style: AppTextStyles.labelSmall.primary),
                      ],
                    ),
                  ),
                ),
                _TimeBlock(time: arrivalTime, place: 'DAD', isEnd: true),
              ],
            ),
            AppSpacing.vXxl,
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onTap,
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ).fadeInScale(delay: Duration(milliseconds: delay)),
    );
  }

  Widget _buildAirlineLogo(String name) {
    Color color;
    if (name.contains('Vietnam')) {
      color = const Color(0xFF005b82);
    } else if (name.contains('Bamboo')) {
      color = const Color(0xFF4ea140);
    } else {
      color = const Color(0xFFe61937); // Vietjet
    }

    return Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          name.substring(0, 1),
          style: AppTextStyles.titleLarge.copyWith(color: color),
        ),
      ),
    );
  }
}

class _TimeBlock extends StatelessWidget {
  final String time;
  final String place;
  final bool isEnd;

  const _TimeBlock({required this.time, required this.place, this.isEnd = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(time, style: AppTextStyles.titleLarge),
        AppSpacing.vXs,
        Text(place, style: AppTextStyles.labelMedium.secondary),
      ],
    );
  }
}
