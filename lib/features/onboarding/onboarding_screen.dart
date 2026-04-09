import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/theme/app_colors.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      image: 'https://images.unsplash.com/photo-1555921015-5532091f6026?w=1200',
      title: 'Discover Vietnam',
      subtitle: 'From the lanterns of Hoi An to the peaks of Sa Pa,\nexplore every corner of this beautiful country',
      emoji: '🏮',
    ),
    _OnboardingData(
      image: 'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=1200',
      title: 'Taste the Culture',
      subtitle: 'Savor authentic Vietnamese cuisine,\nfrom street food to fine dining experiences',
      emoji: '🍜',
    ),
    _OnboardingData(
      image: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=1200',
      title: 'Plan Your Journey',
      subtitle: 'Book flights, tours, and hotels.\nAll in one place, all for you',
      emoji: '✈️',
    ),
  ];

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Page View
          PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Image
                  Image.network(
                    page.image,
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.3),
                          Colors.black.withValues(alpha: 0.85),
                        ],
                        stops: const [0.2, 0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Bottom Content
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Emoji
                    Text(
                      _pages[_currentPage].emoji,
                      style: const TextStyle(fontSize: 40),
                    ).animate(key: ValueKey(_currentPage))
                      .fadeIn(duration: 400.ms)
                      .scale(begin: const Offset(0.5, 0.5)),

                    const SizedBox(height: 16),

                    // Title
                    Text(
                      _pages[_currentPage].title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ).animate(key: ValueKey('title_$_currentPage'))
                      .fadeIn(duration: 500.ms, delay: 100.ms)
                      .slideX(begin: 0.1, end: 0),

                    const SizedBox(height: 12),

                    // Subtitle
                    Text(
                      _pages[_currentPage].subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.8),
                        height: 1.6,
                      ),
                    ).animate(key: ValueKey('sub_$_currentPage'))
                      .fadeIn(duration: 500.ms, delay: 200.ms)
                      .slideX(begin: 0.1, end: 0),

                    const SizedBox(height: 40),

                    // Dots + Button Row
                    Row(
                      children: [
                        SmoothPageIndicator(
                          controller: _controller,
                          count: _pages.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor: AppColors.accentGold,
                            dotColor: Colors.white.withValues(alpha: 0.3),
                            dotHeight: 8,
                            dotWidth: 8,
                            expansionFactor: 3,
                            spacing: 6,
                          ),
                        ),
                        const Spacer(),
                        // Next / Get Started Button
                        GestureDetector(
                          onTap: () {
                            if (_currentPage < _pages.length - 1) {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              _navigateToLogin();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: _currentPage == _pages.length - 1 ? 28 : 20,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.4),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _currentPage == _pages.length - 1
                                      ? 'Explorer Now'
                                      : 'Next',
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward_rounded,
                                    color: Colors.white, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Skip button
                    if (_currentPage < _pages.length - 1) ...[
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: _navigateToLogin,
                          child: Text(
                            'Skip',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.5),
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final String image;
  final String title;
  final String subtitle;
  final String emoji;

  _OnboardingData({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.emoji,
  });
}
