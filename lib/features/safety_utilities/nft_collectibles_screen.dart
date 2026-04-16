import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/gradient_background.dart';

class NftCollectiblesScreen extends StatelessWidget {
  const NftCollectiblesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Digital Souvenirs', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            // Status Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Vault', style: AppTextStyles.titleLarge),
                    Text('0x38Bc...71FE', style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance_wallet, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text('4 NFTs', style: AppTextStyles.labelMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // NFT Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
              children: [
                _buildNftCard('Golden Bridge Hands', 'Da Nang - Minted Oct 2026', 'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800', true),
                _buildNftCard('Bitexco Helipad', 'HCMC - Minted Jan 2026', 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800', true),
                _buildNftCard('Ha Long Dragon', 'Quang Ninh - Rare Drop', 'https://images.unsplash.com/photo-1533050487297-09b450131914?w=800', true),
                _buildNftCard('Hoan Kiem Turtle', 'Hanoi - Locked', 'https://images.unsplash.com/photo-1553531384-cc64ac80f931?w=800', false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNftCard(String title, String details, String imageUrl, bool owned) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: owned ? AppColors.accentGold : Colors.white12, width: owned ? 2 : 1),
        boxShadow: owned ? [BoxShadow(color: AppColors.accentGold.withValues(alpha: 0.2), blurRadius: 20)] : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover),
                  if (!owned) Container(color: Colors.black54),
                  if (!owned) const Center(child: Icon(Icons.lock, color: Colors.white, size: 32)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelMedium, maxLines: 1),
                const SizedBox(height: 4),
                Text(details, style: TextStyle(color: owned ? AppColors.accentGold : AppColors.textTertiary, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
