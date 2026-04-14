import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/app_back_button.dart';
import '../../core/utils/app_animations.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        leading: const Padding(
           padding: EdgeInsets.only(left: 10),
           child: AppBackButton(),
        ),
        title: Text('New Post', style: AppTextStyles.displayMedium),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 12),
            child: GestureDetector(
              onTap: () {
                // Publish logic
                Navigator.pop(context);
              },
              child: Text('Share', style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppSpacing.screenH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.vLg,
              
              // Image/Media Box
              GlassContainer.light(
                height: 300,
                borderRadius: 24,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.gallery_add, size: 48, color: AppColors.primary),
                    AppSpacing.vMd,
                    Text('Tap to add photo or video', style: AppTextStyles.titleMedium),
                  ],
                ),
              ).fadeInUp(),
              
              AppSpacing.vXxl,
              
              // Caption Input
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write a caption...',
                  hintStyle: AppTextStyles.bodyLarge.secondary,
                  border: InputBorder.none,
                ),
                style: AppTextStyles.bodyLarge,
              ).fadeInUp(delay: 100.ms),

              const Divider(),
              
              // Location Tagger
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Iconsax.location_add, color: AppColors.textPrimary),
                title: Text('Add Location', style: AppTextStyles.titleMedium),
                trailing: const Icon(Iconsax.arrow_right_3, size: 18),
                onTap: () {},
              ).fadeInUp(delay: 200.ms),
              
              const Divider(),
              
              // Tag people
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Iconsax.tag_user, color: AppColors.textPrimary),
                title: Text('Tag People', style: AppTextStyles.titleMedium),
                trailing: const Icon(Iconsax.arrow_right_3, size: 18),
                onTap: () {},
              ).fadeInUp(delay: 300.ms),
              
            ],
          ),
        ),
      ),
    );
  }
}
