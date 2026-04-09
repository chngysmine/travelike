import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const OnboardingScreen(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image - Vietnamese landscape
          Image.network(
            'https://images.unsplash.com/photo-1528127269322-539801943592?w=1200',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.3),
            colorBlendMode: BlendMode.darken,
          ),

          // Gradient overlay from bottom
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.6),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                // Welcome text
                Text(
                  'Welcome to',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withValues(alpha: 0.9),
                    letterSpacing: 2,
                  ),
                ).animate()
                  .fadeIn(duration: 800.ms, delay: 400.ms)
                  .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 8),

                // Vietnam text
                Text(
                  'Vietnam',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 56,
                    fontWeight: FontWeight.w800,
                    color: AppColors.accentGold,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                ).animate()
                  .fadeIn(duration: 800.ms, delay: 800.ms)
                  .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.0, 1.0)),

                const SizedBox(height: 16),

                // Tagline
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                      bottom: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                    ),
                  ),
                  child: Text(
                    '🏮 Discover • Explore • Experience 🏮',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.8),
                      letterSpacing: 1.5,
                    ),
                  ),
                ).animate()
                  .fadeIn(duration: 600.ms, delay: 1200.ms),

                const Spacer(flex: 1),

                // Travelike logo text
                Text(
                  'TRAVELIKE',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 8,
                  ),
                ).animate()
                  .fadeIn(duration: 600.ms, delay: 1600.ms),

                const SizedBox(height: 8),

                Text(
                  'Your All-in-One Travel Companion',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.6),
                    letterSpacing: 1,
                  ),
                ).animate()
                  .fadeIn(duration: 600.ms, delay: 1800.ms),

                const SizedBox(height: 40),

                // Loading indicator
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withValues(alpha: 0.5),
                    ),
                    strokeWidth: 2,
                  ),
                ).animate()
                  .fadeIn(duration: 400.ms, delay: 2000.ms),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
