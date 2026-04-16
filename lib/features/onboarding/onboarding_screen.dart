import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/utils/page_transitions.dart';
import '../../core/utils/app_animations.dart';
import '../auth/signin_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Discover Vietnam',
      'desc': 'Explore hidden gems, majestic landscapes, and breathtaking views across the country.',
      'image': 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', // Halong Bay
    },
    {
      'title': 'Taste the Culture',
      'desc': 'Indulge in authentic Vietnamese cuisine and discover flavors that tell a story.',
      'image': 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800', // Pho
    },
    {
      'title': 'Seamless Travel',
      'desc': 'Book flights, hotels, and tours all in one place with a single tap.',
      'image': 'https://images.unsplash.com/photo-1533050487297-09b450131914?w=800', // Hoi An
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageTransitions.fadeScale(const SigninScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ==================== BACKGROUND PAGER ====================
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: _pages[index]['image']!,
                    fit: BoxFit.cover,
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                        stops: const [0.4, 1.0],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // ==================== SKIP BUTTON ====================
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  PageTransitions.fadeScale(const SigninScreen()),
                );
              },
              child: GlassContainer.dark(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                borderRadius: 20,
                child: Text('Skip', style: AppTextStyles.labelMedium.white),
              ),
            ),
          ).fadeInUp(),

          // ==================== BOTTOM CONTENT ====================
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: GlassContainer.dark(
              padding: const EdgeInsets.all(32),
              borderRadius: 32,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentIndex == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == index ? AppColors.primary : Colors.white24,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  
                  AppSpacing.vXxl,

                  // Text animated automatically smoothly using AnimatedSwitcher
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Column(
                      key: ValueKey<int>(_currentIndex),
                      children: [
                        Text(
                          _pages[_currentIndex]['title']!,
                          style: AppTextStyles.displayMedium.white,
                          textAlign: TextAlign.center,
                        ),
                        AppSpacing.vLg,
                        Text(
                          _pages[_currentIndex]['desc']!,
                          style: AppTextStyles.bodyMedium.white70,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  AppSpacing.vXxl,

                  // Start button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(
                        _currentIndex == _pages.length - 1 ? 'Get Started' : 'Next',
                        style: AppTextStyles.titleMedium.white,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.1, end: 0, duration: 600.ms, curve: Curves.easeOutCubic).fadeIn(duration: 600.ms),
          ),
        ],
      ),
    );
  }
}
