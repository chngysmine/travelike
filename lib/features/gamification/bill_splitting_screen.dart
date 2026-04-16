import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BillSplittingScreen extends StatelessWidget {
  const BillSplittingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Split Bills', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.receipt_2, color: AppColors.textPrimary),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Total Balance Card
            GlassContainer.solid(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              color: AppColors.primaryDark,
              child: Column(
                children: [
                  Text('You are owed', style: AppTextStyles.labelMedium.copyWith(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text('\$145.50', style: AppTextStyles.displayLarge.copyWith(color: Colors.white)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.textPrimary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('Add Expense', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: Colors.white24),
                          ),
                          child: const Text('Settle Up'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Text('Recent Expenses in Vietnam', style: AppTextStyles.titleSmall),
            const SizedBox(height: 16),
            
            // List of splits
            _buildExpenseItem(
              title: 'Seafood Dinner in Da Nang',
              date: 'Oct 14',
              totalAmt: '\$80.00',
              paidBy: 'You paid, splitting 4 ways',
              statusAmt: '+\$60.00',
              statusColor: Colors.green,
            ),
            _buildExpenseItem(
              title: 'Grab taxi to Hoi An',
              date: 'Oct 15',
              totalAmt: '\$15.00',
              paidBy: 'Linh paid, you owe',
              statusAmt: '-\$5.00',
              statusColor: Colors.redAccent,
            ),
            _buildExpenseItem(
              title: 'Ba Na Hills Tickets',
              date: 'Oct 16',
              totalAmt: '\$120.00',
              paidBy: 'Khoa paid, you owe',
              statusAmt: '-\$30.00',
              statusColor: Colors.redAccent,
            ),
            _buildExpenseItem(
              title: 'Coconut Coffees',
              date: 'Oct 17',
              totalAmt: '\$10.00',
              paidBy: 'You paid, splitting 2 ways',
              statusAmt: '+\$5.00',
              statusColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseItem({
    required String title,
    required String date,
    required String totalAmt,
    required String paidBy,
    required String statusAmt,
    required Color statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(16),
        borderRadius: 20,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.receipt_long, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall),
                  const SizedBox(height: 4),
                  Text('$date • $paidBy', style: AppTextStyles.labelSmall),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(statusAmt, style: AppTextStyles.labelMedium.copyWith(color: statusColor)),
                const SizedBox(height: 4),
                Text('Total: $totalAmt', style: AppTextStyles.labelSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
