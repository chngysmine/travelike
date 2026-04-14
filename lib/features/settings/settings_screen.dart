import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/app_back_button.dart';
import '../../core/utils/app_animations.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import '../auth/signin_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leading: const Padding(
           padding: EdgeInsets.only(left: 10),
           child: AppBackButton(),
        ),
        title: Text('Settings', style: AppTextStyles.displayMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screen,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== PROFILE SUMMARY ====================
            GlassContainer.solid(
              padding: const EdgeInsets.all(16),
              borderRadius: 24,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(MockData.userAvatar),
                  ),
                  AppSpacing.hLg,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(MockData.userFullName, style: AppTextStyles.titleLarge),
                        Text(MockData.userEmail, style: AppTextStyles.labelMedium.secondary),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.primarySurface, shape: BoxShape.circle),
                    child: const Icon(Iconsax.edit_2, color: AppColors.primary, size: 20),
                  ),
                ],
              ),
            ).fadeInUp(),

            AppSpacing.vXxl,

            // ==================== SETTINGS GROUPS ====================
            _buildSection(
              'Account Options',
              [
                _SettingsItem(icon: Iconsax.user, label: 'Personal Information', onTap: () {}),
                _SettingsItem(icon: Iconsax.card, label: 'Payment Methods', onTap: () {}),
                _SettingsItem(icon: Iconsax.lock, label: 'Privacy & Security', onTap: () {}),
              ],
              delay: 50,
            ),
            
            AppSpacing.vLg,

            _buildSection(
              'App Preferences',
              [
                _SettingsItem(icon: Iconsax.notification, label: 'Notifications', value: 'On', onTap: () {}),
                _SettingsItem(icon: Iconsax.global, label: 'Language', value: 'English', onTap: () {}),
                _SettingsItem(icon: Icons.dark_mode_outlined, label: 'Dark Mode', isToggle: true, onTap: () {}),
              ],
              delay: 100,
            ),

            AppSpacing.vLg,

            _buildSection(
              'Support & About',
              [
                _SettingsItem(icon: Iconsax.message_question, label: 'Help Center', onTap: () {}),
                _SettingsItem(icon: Iconsax.document_text, label: 'Terms of Service', onTap: () {}),
                _SettingsItem(icon: Iconsax.info_circle, label: 'About Travelike', onTap: () {}),
              ],
              delay: 150,
            ),
            
            AppSpacing.vXxl,

            // ==================== LOGOUT BUTTON ====================
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.accentRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: AppColors.accentRed.withValues(alpha: 0.2))),
                ),
                child: Text('Log Out', style: AppTextStyles.titleMedium.copyWith(color: AppColors.accentRed)),
              ),
            ).fadeInUp(delay: const Duration(milliseconds: 200)),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items, {required int delay}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 12),
          child: Text(title, style: AppTextStyles.labelMedium.secondary.copyWith(letterSpacing: 0.5)),
        ),
        GlassContainer.solid(
          padding: EdgeInsets.zero,
          borderRadius: 24,
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++)
                Column(
                  children: [
                    items[i],
                    if (i < items.length - 1)
                      Divider(color: Colors.grey.withValues(alpha: 0.1), height: 1, indent: 56),
                  ],
                ),
            ],
          ),
        ),
      ],
    ).fadeInUp(delay: Duration(milliseconds: delay));
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text('Log Out', style: AppTextStyles.displaySmall),
        content: Text('Are you sure you want to log out from Travelike?', style: AppTextStyles.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppTextStyles.labelLarge.secondary),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransitions.fadeScale(const SigninScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentRed),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final bool isToggle;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.label,
    this.value,
    this.isToggle = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.primarySurface.withValues(alpha: 0.5), borderRadius: AppSpacing.borderMd),
              child: Icon(icon, size: 20, color: AppColors.primary),
            ),
            AppSpacing.hLg,
            Expanded(
              child: Text(label, style: AppTextStyles.titleMedium),
            ),
            if (value != null) ...[
              Text(value!, style: AppTextStyles.labelMedium.secondary),
              AppSpacing.hSm,
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textTertiary),
            ] else if (isToggle) ...[
              SizedBox(
                 height: 24,
                 child: Switch(
                   value: false,
                   onChanged: (v) {},
                   activeThumbColor: AppColors.primary,
                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                 ),
              )
            ] else ...[
              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textTertiary),
            ],
          ],
        ),
      ),
    );
  }
}
