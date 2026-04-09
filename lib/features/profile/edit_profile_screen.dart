import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: MockData.userFullName);
  final _emailController = TextEditingController(text: MockData.userEmail);
  final _bioController = TextEditingController(text: MockData.userBio);
  final _phoneController = TextEditingController(text: '+84 908 123 456');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20)),
                    const Spacer(),
                    Text('Edit Profile', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    TextButton(onPressed: () => Navigator.pop(context), child: Text('Save', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary))),
                  ],
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 28),
                // Avatar
                Stack(
                  children: [
                    Container(
                      width: 120, height: 120,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 4), boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 20)]),
                      child: ClipOval(child: CachedNetworkImage(imageUrl: MockData.userAvatar, fit: BoxFit.cover)),
                    ),
                    Positioned(
                      bottom: 0, right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                        child: const Icon(Iconsax.camera, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms, delay: 100.ms).scale(begin: const Offset(0.9, 0.9)),
                const SizedBox(height: 32),
                _buildField('Full Name', _nameController, Iconsax.user).animate().fadeIn(duration: 400.ms, delay: 200.ms),
                const SizedBox(height: 16),
                _buildField('Email', _emailController, Iconsax.sms).animate().fadeIn(duration: 400.ms, delay: 300.ms),
                const SizedBox(height: 16),
                _buildField('Phone', _phoneController, Iconsax.call).animate().fadeIn(duration: 400.ms, delay: 400.ms),
                const SizedBox(height: 16),
                _buildField('Bio', _bioController, Iconsax.edit, maxLines: 3).animate().fadeIn(duration: 400.ms, delay: 500.ms),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity, height: 56,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: Text('Update Profile', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 600.ms),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, IconData icon, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.textTertiary, size: 20),
            filled: true, fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.grey.shade200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.primary)),
          ),
        ),
      ],
    );
  }
}
