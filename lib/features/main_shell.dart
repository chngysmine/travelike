import 'package:flutter/material.dart';
import '../core/widgets/custom_bottom_nav.dart';
import '../core/widgets/gradient_background.dart';
import 'home/home_screen.dart';
import 'reels/reels_screen.dart';
import 'social/create_post_screen.dart';
import 'weather/weather_screen.dart';
import 'profile/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ReelsScreen(),
    const CreatePostScreen(),
    const WeatherScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: CustomBottomNav(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
