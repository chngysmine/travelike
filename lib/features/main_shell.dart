import 'package:flutter/material.dart';
import '../core/widgets/custom_bottom_nav.dart';
import '../core/widgets/gradient_background.dart';
import 'home/home_screen.dart';
import 'reels/reels_screen.dart';
import 'social/create_post_screen.dart';
import 'weather/weather_screen.dart';
import 'profile/profile_screen.dart';
import 'ai/ai_assistant_screen.dart';
import '../core/utils/page_transitions.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // Cập nhật lại danh sách screens
  final List<Widget> _screens = [
    const HomeScreen(),
    const ReelsScreen(),
    const SizedBox(), // Index 2 chỉ là một placeholder trống, không thực sự render
    const WeatherScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 2) {
      // Khi bấm vào nút chính giữa (+), mở đè màn hình CreatePostScreen lên
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const CreatePostScreen()));
    } else {
      // Các nút khác thì chuyển đổi màn hình trong IndexedStack bình thường
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            IndexedStack(index: _currentIndex, children: _screens),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomNav(
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70), // Lift above bottom nav
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              Navigator.of(context).push(
                PageTransitions.slideUp(const AiAssistantScreen()),
              );
            },
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEC4899).withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Iconsax.magic_star, color: Colors.white, size: 28),
            ),
          ),
        ),
      ),
    );
  }
}
