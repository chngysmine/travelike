import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../core/theme/app_colors.dart';

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
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20), onPressed: () => Navigator.pop(context)),
        title: Text('Credit Card Details', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Method
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border.all(color: Colors.white.withValues(alpha: 0.2), style: BorderStyle.solid), borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment\nMethod', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.7))),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _PaymentChip(label: '💳', isSelected: _selectedMethod == 0, onTap: () => setState(() => _selectedMethod = 0)),
                      const SizedBox(width: 12),
                      _PaymentChip(label: '🅿️', isSelected: _selectedMethod == 1, onTap: () => setState(() => _selectedMethod = 1)),
                      const SizedBox(width: 12),
                      _PaymentChip(label: '🍎', isSelected: _selectedMethod == 2, onTap: () => setState(() => _selectedMethod = 2)),
                      const SizedBox(width: 12),
                      _PaymentChip(label: '🔵', isSelected: _selectedMethod == 3, onTap: () => setState(() => _selectedMethod = 3)),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 28),
            _buildField('Name on card', 'Meet Patel', Iconsax.user).animate().fadeIn(duration: 400.ms, delay: 100.ms),
            const SizedBox(height: 20),
            _buildField('Card number', '0000 0000 0000 0000', Iconsax.card).animate().fadeIn(duration: 400.ms, delay: 200.ms),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: _buildDropdown('Month', Iconsax.calendar_1)),
              const SizedBox(width: 12),
              Expanded(child: _buildDropdown('Year', Iconsax.calendar_1)),
            ]).animate().fadeIn(duration: 400.ms, delay: 300.ms),
            const SizedBox(height: 20),
            _buildField('Card Security Code', 'Code', Iconsax.lock).animate().fadeIn(duration: 400.ms, delay: 400.ms),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity, height: 56,
              child: ElevatedButton(
                onPressed: () => _showPaymentSuccess(context),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: Text('Pay', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ).animate().fadeIn(duration: 400.ms, delay: 500.ms).slideY(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha: 0.8))),
        const SizedBox(height: 8),
        TextField(
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.3)),
            prefixIcon: Icon(icon, color: Colors.white.withValues(alpha: 0.5), size: 20),
            filled: true, fillColor: Colors.white.withValues(alpha: 0.08),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.15))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.primary)),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(String hint, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withValues(alpha: 0.15))),
      child: Row(children: [
        Text(hint, style: GoogleFonts.inter(fontSize: 14, color: Colors.white.withValues(alpha: 0.3))),
        const Spacer(),
        Icon(Icons.keyboard_arrow_down, color: Colors.white.withValues(alpha: 0.5)),
      ]),
    );
  }

  void _showPaymentSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(color: AppColors.chipGreen.withValues(alpha: 0.15), shape: BoxShape.circle),
                child: const Icon(Icons.check_circle, color: AppColors.chipGreen, size: 48),
              ).animate().scale(begin: const Offset(0.5, 0.5), duration: 400.ms, curve: Curves.elasticOut),
              const SizedBox(height: 20),
              Text('Payment Successful!', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text('Your booking has been confirmed.\nEnjoy your trip! 🎉', textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () { Navigator.pop(context); Navigator.pop(context); },
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  child: Text('Done', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _PaymentChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: isSelected ? AppColors.primary.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent, width: 2)),
        child: Text(label, style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
