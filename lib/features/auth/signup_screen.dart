import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/utils/app_animations.dart';
import '../../core/utils/page_transitions.dart';
import '../main_shell.dart';
import 'signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ==================== BACKGROUND ====================
          CachedNetworkImage(
            imageUrl: 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', // Halong Bay
            fit: BoxFit.cover,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withValues(alpha: 0.3), Colors.black.withValues(alpha: 0.85)],
              ),
            ),
          ),
          
          // ==================== CONTENT ====================
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  AppSpacing.vXxl, 
                  
                  // Header
                  Text('Create Account', style: AppTextStyles.hero.copyWith(color: Colors.white)).fadeInUp(),
                  AppSpacing.vSm,
                  Text('Start your journey with us today.', style: AppTextStyles.bodyMedium.white70).fadeInUp(delay: 100.ms),
                  
                  AppSpacing.vXxl,

                  // ==================== REGISTER FORM CARD ====================
                  GlassContainer.dark(
                    padding: const EdgeInsets.all(24),
                    borderRadius: 32,
                    child: Column(
                      children: [
                        _buildInputField(
                          hint: 'Full Name',
                          icon: Iconsax.user,
                        ),
                        AppSpacing.vLg,
                        _buildInputField(
                          hint: 'Email Address',
                          icon: Iconsax.sms,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        AppSpacing.vLg,
                        _buildInputField(
                          hint: 'Password',
                          icon: Iconsax.lock,
                          obscureText: _obscurePassword,
                          suffixIcon: GestureDetector(
                            onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                            child: Icon(
                              _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                              color: Colors.white70,
                              size: 20,
                            ),
                          ),
                        ),
                        AppSpacing.vLg,
                        _buildInputField(
                          hint: 'Confirm Password',
                          icon: Iconsax.lock,
                          obscureText: _obscureConfirm,
                          suffixIcon: GestureDetector(
                            onTap: () => setState(() => _obscureConfirm = !_obscureConfirm),
                            child: Icon(
                              _obscureConfirm ? Iconsax.eye_slash : Iconsax.eye,
                              color: Colors.white70,
                              size: 20,
                            ),
                          ),
                        ),
                        
                        AppSpacing.vXxl,

                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageTransitions.fadeScale(const MainShell()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: Text('Sign Up', style: AppTextStyles.titleMedium.white),
                          ),
                        ),
                      ],
                    ),
                  ).fadeInUp(delay: 200.ms),

                  AppSpacing.vXxl,

                  // ==================== LOGIN LINK ====================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ', style: AppTextStyles.bodyMedium.white70),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransitions.fadeScale(const SigninScreen()),
                          );
                        },
                        child: Text('Sign In', style: AppTextStyles.titleMedium.primary),
                      ),
                    ],
                  ).fadeInUp(delay: 300.ms),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTextStyles.titleMedium.white,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.titleMedium.white70,
        prefixIcon: Icon(icon, color: Colors.white70, size: 22),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.black26,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.white24, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }
}
