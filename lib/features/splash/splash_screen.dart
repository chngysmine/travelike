import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/page_transitions.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Allow animation to play, then navigate
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageTransitions.fadeScale(const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Hide status bar for splash
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Elegant dark background variant or gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2C3E50), Color(0xFF000000)],
              ),
            ),
          ),
          
          // Center Logo
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Minimalist vector-style hero icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.1),
                        blurRadius: 40,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.flight_takeoff_rounded, size: 48, color: Color(0xFF2C3E50)),
                  ),
                )
                    .animate()
                    .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1), duration: 800.ms, curve: Curves.easeOutBack)
                    .fadeIn(duration: 500.ms),
                
                const SizedBox(height: 24),
                
                Text(
                  'Travelike',
                  style: AppTextStyles.hero.copyWith(color: Colors.white, fontSize: 42),
                )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .slideY(begin: 0.2, end: 0, delay: 400.ms, duration: 600.ms, curve: Curves.easeOutCubic),
                
                const SizedBox(height: 8),
                
                Text(
                  'Vietnam at your fingertips',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: Colors.white70,
                    letterSpacing: 2,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 800.ms, duration: 600.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
