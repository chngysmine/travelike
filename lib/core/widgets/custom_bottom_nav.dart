import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../theme/app_colors.dart';

/// Premium liquid-glass bottom navigation bar.
/// Features frosted backdrop, animated icon transitions, and gradient center button.
class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy padding dưới của thiết bị (an toàn cho thanh điều hướng iOS/Android)
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Padding(
      // Cách lề dưới ít lại: chỉ cộng thêm một khoảng nhỏ (ví dụ 4px) trên vùng an toàn
      padding: EdgeInsets.fromLTRB(
        24,
        0,
        24,
        bottomPadding > 0 ? bottomPadding + 4 : 12,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    // Giảm alpha xuống để độ trong suốt (nhìn xuyên thấu) rõ ràng hơn
                    Colors.white.withValues(alpha: 0.65),
                    Colors.white.withValues(alpha: 0.35),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: SizedBox(
                  height: 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _NavItem(
                        icon: Iconsax.home_2,
                        activeIcon: Icons.home_rounded,
                        label: 'Home',
                        isActive: currentIndex == 0,
                        onTap: () => onTap(0),
                      ),
                      _NavItem(
                        icon: Iconsax.video_play,
                        activeIcon: Icons.play_circle_fill_rounded,
                        label: 'Reels',
                        isActive: currentIndex == 1,
                        onTap: () => onTap(1),
                      ),
                      _NavItem(
                        icon: Iconsax.add_square,
                        activeIcon: Iconsax.add_square,
                        label: 'Create',
                        isActive: currentIndex == 2,
                        onTap: () => onTap(2),
                      ),
                      _NavItem(
                        icon: Iconsax.sun_1,
                        activeIcon: Icons.wb_sunny_rounded,
                        label: 'Weather',
                        isActive: currentIndex == 3,
                        onTap: () => onTap(3),
                      ),
                      _NavItem(
                        icon: Iconsax.user,
                        activeIcon: Iconsax.user,
                        label: 'Profile',
                        isActive: currentIndex == 4,
                        onTap: () => onTap(4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        height: 52,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey<bool>(isActive),
                color: isActive ? AppColors.primary : Colors.black54,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: isActive ? 10 : 9,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primary : Colors.black54,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

