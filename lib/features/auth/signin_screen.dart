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
import 'signup_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _obscureText = true;

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
                  AppSpacing.vXxl, // Pushes content down a bit
                  
                  // Header
                  Text('Welcome Back', style: AppTextStyles.hero.copyWith(color: Colors.white)).fadeInUp(),
                  AppSpacing.vSm,
                  Text('Sign in to continue your adventure.', style: AppTextStyles.bodyMedium.white70).fadeInUp(delay: 100.ms),
                  
                  AppSpacing.vXxl,

                  // ==================== SIGNIN FORM CARD ====================
                  GlassContainer.dark(
                    padding: const EdgeInsets.all(24),
                    borderRadius: 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildInputField(
                          hint: 'Email Address',
                          icon: Iconsax.sms,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        AppSpacing.vLg,
                        _buildInputField(
                          hint: 'Password',
                          icon: Iconsax.lock,
                          obscureText: _obscureText,
                          suffixIcon: GestureDetector(
                            onTap: () => setState(() => _obscureText = !_obscureText),
                            child: Icon(
                              _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                              color: Colors.white70,
                              size: 20,
                            ),
                          ),
                        ),
                        AppSpacing.vMd,
                        Text('Forgot Password?', style: AppTextStyles.labelMedium.white70),
                        
                        AppSpacing.vXxl,

                        // Login Button
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
                            child: Text('Sign In', style: AppTextStyles.titleMedium.white),
                          ),
                        ),
                      ],
                    ),
                  ).fadeInUp(delay: 200.ms),

                  AppSpacing.vXxl,

                  // ==================== SOCIAL LOGIN ====================
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.white24)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Or continue with', style: AppTextStyles.labelMedium.white70),
                      ),
                      const Expanded(child: Divider(color: Colors.white24)),
                    ],
                  ).fadeInUp(delay: 300.ms),

                  AppSpacing.vLg,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialButton(icon: Icons.g_mobiledata_rounded, delay: 350),
                      AppSpacing.hLg,
                      _SocialButton(icon: Icons.apple_rounded, delay: 400),
                      AppSpacing.hLg,
                      _SocialButton(icon: Icons.facebook_rounded, delay: 450),
                    ],
                  ),

                  AppSpacing.vXxl,
                  AppSpacing.vXxl,

                  // ==================== SIGN UP LINK ====================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? ', style: AppTextStyles.bodyMedium.white70),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransitions.fadeScale(const SignupScreen()),
                          );
                        },
                        child: Text('Sign Up', style: AppTextStyles.titleMedium.primary),
                      ),
                    ],
                  ).fadeInUp(delay: 500.ms),

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

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final int delay;

  const _SocialButton({required this.icon, required this.delay});

  @override
  Widget build(BuildContext context) {
    return GlassContainer.dark(
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      child: Icon(icon, color: Colors.white, size: 32),
    ).fadeInUp(delay: Duration(milliseconds: delay));
  }
}
