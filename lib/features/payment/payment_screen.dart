import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/app_back_button.dart';
import '../../core/utils/app_animations.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141416), // Premium Dark
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Padding(
           padding: EdgeInsets.only(left: 10),
           child: AppBackButton(
             iconColor: Colors.white,
             backgroundColor: Colors.white12,
           ),
        ),
        title: Text('Checkout', style: AppTextStyles.displayMedium.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.screen,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== ORDER SUMMARY ====================
            Text('Order Summary', style: AppTextStyles.titleMedium.white70).fadeInUp(),
            AppSpacing.vLg,
            GlassContainer.dark(
              borderRadius: 24,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vietnam Airlines Flight', style: AppTextStyles.titleMedium.white),
                      Text('\$120.00', style: AppTextStyles.titleMedium.white),
                    ],
                  ),
                  AppSpacing.vMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Taxes & Fees', style: AppTextStyles.labelMedium.white70),
                      Text('\$15.50', style: AppTextStyles.labelMedium.white70),
                    ],
                  ),
                  AppSpacing.vLg,
                  const Divider(color: Colors.white12, height: 1),
                  AppSpacing.vLg,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyles.titleLarge.white),
                      Text('\$135.50', style: AppTextStyles.price.copyWith(color: AppColors.accentGold)),
                    ],
                  ),
                ],
              ),
            ).fadeInUp(delay: const Duration(milliseconds: 50)),
            
            AppSpacing.vXxl,
            AppSpacing.vMd,

            // ==================== PAYMENT METHODS ====================
            Text('Payment Method', style: AppTextStyles.titleMedium.white70).fadeInUp(delay: const Duration(milliseconds: 100)),
            AppSpacing.vLg,
            
            _PaymentMethodCard(
              title: 'Apple Pay',
              icon: Icons.apple_rounded,
              index: 0,
              selectedIndex: _selectedMethod,
              onTap: () => setState(() => _selectedMethod = 0),
            ).fadeInUp(delay: const Duration(milliseconds: 150)),
            
            _PaymentMethodCard(
              title: 'Credit Card',
              icon: Iconsax.card,
              index: 1,
              selectedIndex: _selectedMethod,
              onTap: () => setState(() => _selectedMethod = 1),
              isExpanded: _selectedMethod == 1,
            ).fadeInUp(delay: const Duration(milliseconds: 200)),
            
            _PaymentMethodCard(
              title: 'MoMo E-Wallet',
              icon: Icons.account_balance_wallet_rounded,
              index: 2,
              selectedIndex: _selectedMethod,
              onTap: () => setState(() => _selectedMethod = 2),
            ).fadeInUp(delay: const Duration(milliseconds: 250)),

            AppSpacing.vXxl,
            AppSpacing.vXxl,

            // ==================== CHECKOUT BUTTON ====================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showSuccessDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text('Pay \$135.50', style: AppTextStyles.titleMedium.white),
              ),
            ).fadeInUp(delay: const Duration(milliseconds: 300)),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GlassContainer.dark(
          padding: const EdgeInsets.all(32),
          borderRadius: 32,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.chipGreen.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.tick_circle, color: AppColors.chipGreen, size: 48),
              ).fadeInScale(),
              AppSpacing.vXxl,
              Text('Payment Successful!', style: AppTextStyles.displayMedium.white),
              AppSpacing.vLg,
              Text(
                'Your flight has been booked successfully. E-ticket has been sent to your email.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.white70,
              ),
              AppSpacing.vXxl,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back
                  },
                  child: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ).fadeInUp(),
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;
  final bool isExpanded;

  const _PaymentMethodCard({
    required this.title,
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.white12,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: isSelected ? AppColors.primary : Colors.white, size: 28),
                AppSpacing.hLg,
                Expanded(child: Text(title, style: AppTextStyles.titleMedium.white)),
                Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: isSelected ? AppColors.primary : Colors.white54, width: 2),
                  ),
                  child: isSelected
                      ? Center(child: Container(width: 12, height: 12, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary)))
                      : null,
                ),
              ],
            ),
            if (isExpanded) ...[
              AppSpacing.vLg,
              const Divider(color: Colors.white12, height: 1),
              AppSpacing.vLg,
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    const Icon(Icons.credit_card_rounded, color: Colors.white54, size: 20),
                    AppSpacing.hMd,
                    Expanded(
                      child: TextField(
                        style: AppTextStyles.titleMedium.white,
                        decoration: InputDecoration(
                          hintText: 'Card Number',
                          hintStyle: AppTextStyles.titleMedium.white70,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.vMd,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(16)),
                      child: TextField(
                        style: AppTextStyles.titleMedium.white,
                        decoration: InputDecoration(
                          hintText: 'MM/YY',
                          hintStyle: AppTextStyles.titleMedium.white70,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.hMd,
                  Expanded(
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(16)),
                      child: TextField(
                        style: AppTextStyles.titleMedium.white,
                        decoration: InputDecoration(
                          hintText: 'CVC',
                          hintStyle: AppTextStyles.titleMedium.white70,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
