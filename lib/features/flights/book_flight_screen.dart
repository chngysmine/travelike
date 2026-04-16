import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class BookFlightScreen extends StatelessWidget {
  const BookFlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Search Flights', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Flight Search Form
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 24,
              child: Column(
                children: [
                  // Form Fields
                  _buildSearchField(Icons.flight_takeoff, 'From', 'Ho Chi Minh City (SGN)'),
                  const Padding(padding: EdgeInsets.only(left: 32), child: Divider(color: Colors.black12)),
                  _buildSearchField(Icons.flight_land, 'To', 'Hanoi (HAN)'),
                  const Padding(padding: EdgeInsets.only(left: 32), child: Divider(color: Colors.black12)),
                  _buildSearchField(Icons.calendar_today, 'Date', 'Thu, Oct 20 - Sat, Oct 22'),
                  const Padding(padding: EdgeInsets.only(left: 32), child: Divider(color: Colors.black12)),
                  _buildSearchField(Icons.person, 'Passengers', '1 Adult, Economy'),
                  
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('Find Flights', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Special Offers', style: AppTextStyles.titleLarge),
            const SizedBox(height: 16),
            
            // Offers
            _buildOfferCard(
              'Da Nang Autumn Vibes',
              'Flights from 750k VND',
              'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800',
            ),
            _buildOfferCard(
              'Phu Quoc Escape',
              'Up to 30% off Vietjet Air',
              'https://images.unsplash.com/photo-1528127269322-539801943592?w=800',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
              const SizedBox(height: 2),
              Text(value, style: AppTextStyles.titleSmall),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOfferCard(String title, String subtitle, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 140,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(imageUrl, fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black87, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.titleMedium.copyWith(color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: AppTextStyles.labelSmall.copyWith(color: AppColors.accentGold)),
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
