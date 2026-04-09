import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';

class BookFlightScreen extends StatefulWidget {
  const BookFlightScreen({super.key});

  @override
  State<BookFlightScreen> createState() => _BookFlightScreenState();
}

class _BookFlightScreenState extends State<BookFlightScreen> {
  bool _isOneWay = true;
  String _from = 'SGN';
  String _to = 'DAD';
  String _fromCity = 'Ho Chi Minh City';
  String _toCity = 'Da Nang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Text('Book Your Flight', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                  ],
                ).animate().fadeIn(duration: 400.ms),

                const SizedBox(height: 24),

                // Trip type toggle
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isOneWay = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _isOneWay ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text('One Way',
                                  style: GoogleFonts.inter(
                                    fontSize: 14, fontWeight: FontWeight.w600,
                                    color: _isOneWay ? Colors.white : AppColors.textTertiary,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isOneWay = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: !_isOneWay ? AppColors.primary : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text('Return',
                                  style: GoogleFonts.inter(
                                    fontSize: 14, fontWeight: FontWeight.w600,
                                    color: !_isOneWay ? Colors.white : AppColors.textTertiary,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 100.ms),

                const SizedBox(height: 24),

                // From/To Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12),
                    ],
                  ),
                  child: Column(
                    children: [
                      _AirportTile(code: _from, city: _fromCity, label: 'FROM'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey.shade200)),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  final temp = _from; _from = _to; _to = temp;
                                  final tempC = _fromCity; _fromCity = _toCity; _toCity = tempC;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Iconsax.arrow_swap_horizontal, color: Colors.white, size: 18),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey.shade200)),
                          ],
                        ),
                      ),
                      _AirportTile(code: _to, city: _toCity, label: 'TO'),
                    ],
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: 200.ms),

                const SizedBox(height: 16),

                // Date & Passengers
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('📅  Departure', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textTertiary)),
                            const SizedBox(height: 6),
                            Text('Mar 4, 2026', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('👤  Passengers', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textTertiary)),
                            const SizedBox(height: 6),
                            Text('1 Passenger', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 500.ms, delay: 300.ms),

                const SizedBox(height: 24),

                // Search button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const _FlightResultsScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Iconsax.search_normal, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text('Search Flights', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 400.ms),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AirportTile extends StatelessWidget {
  final String code, city, label;
  const _AirportTile({required this.code, required this.city, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(label == 'FROM' ? Iconsax.airplane : Iconsax.location, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textTertiary, letterSpacing: 1)),
              const SizedBox(height: 2),
              Text(code, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              Text(city, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }
}

class _FlightResultsScreen extends StatelessWidget {
  const _FlightResultsScreen();

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
                    const SizedBox(width: 12),
                    Text('Flight Tickets', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Iconsax.filter, size: 20, color: AppColors.primary),
                    ),
                  ],
                ),
              ),

              // Route info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text('SGN', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                          Text('Ho Chi Minh', style: GoogleFonts.inter(fontSize: 11, color: Colors.white70)),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          const Icon(Iconsax.airplane, color: Colors.white, size: 24),
                          Text('Direct', style: GoogleFonts.inter(fontSize: 11, color: Colors.white70)),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text('DAD', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                          Text('Da Nang', style: GoogleFonts.inter(fontSize: 11, color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Results
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: MockData.flights.length,
                  itemBuilder: (context, index) {
                    final flight = MockData.flights[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(flight['logo'], style: const TextStyle(fontSize: 28)),
                              const SizedBox(width: 12),
                              Text(flight['airline'], style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                              const Spacer(),
                              Text(
                                '\$${flight['price']!.toStringAsFixed(0)}',
                                style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(flight['departureTime'], style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                                  Text(flight['departure'], style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(flight['duration'], style: GoogleFonts.inter(fontSize: 11, color: AppColors.textTertiary)),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Divider(color: Colors.grey.shade300, indent: 20, endIndent: 20),
                                        const Icon(Iconsax.airplane, size: 14, color: AppColors.primary),
                                      ],
                                    ),
                                    Text(flight['stops'], style: GoogleFonts.inter(fontSize: 11, color: AppColors.chipGreen, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(flight['arrivalTime'], style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
                                  Text(flight['arrival'], style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 400.ms, delay: (index * 80).ms);
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
