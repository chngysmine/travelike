import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GroupVotingScreen extends StatelessWidget {
  const GroupVotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Group Decisions', style: AppTextStyles.titleMedium),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.add_circle, color: AppColors.primary),
              onPressed: () {},
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          children: [
            Text('Da Nang Trip 2026', style: AppTextStyles.titleLarge),
            Text('4 Active Polls', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 24),
            
            // Poll Card 1
            _buildPollCard(
              question: 'Tomorrow\'s Breakfast?',
              timeLeft: 'Ends in 2 hours',
              options: ['Pho Thin', 'Banh Mi Phuong', 'Bun Cha'],
              votes: [3, 1, 0],
              hasVotedIndex: 0,
            ),
            
            // Poll Card 2
            _buildPollCard(
              question: 'Evening Activity in Hoi An',
              timeLeft: 'Ends tonight',
              options: ['Night Market & Street Food', 'Lantern Boat Ride', 'Cultural Show'],
              votes: [2, 4, 1],
              hasVotedIndex: 1,
            ),

            // Poll Card 3
            _buildPollCard(
              question: 'Transport to Ba Na Hills',
              timeLeft: 'Voting closed',
              options: ['Private Van (\$40)', 'Metered Taxi (\$50)', 'Rent Motorbikes (\$15)'],
              votes: [4, 0, 1],
              hasVotedIndex: 0,
              isClosed: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollCard({
    required String question, 
    required String timeLeft, 
    required List<String> options, 
    required List<int> votes,
    int? hasVotedIndex,
    bool isClosed = false,
  }) {
    int totalVotes = votes.fold(0, (a, b) => a + b);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: GlassContainer.solid(
        padding: const EdgeInsets.all(20),
        borderRadius: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(question, style: AppTextStyles.titleMedium)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isClosed ? Colors.grey.withValues(alpha: 0.2) : Colors.greenAccent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(isClosed ? 'Closed' : timeLeft, 
                    style: AppTextStyles.labelSmall.copyWith(color: isClosed ? AppColors.textSecondary : Colors.green)
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...List.generate(options.length, (index) {
              final isTopChoice = isClosed && votes[index] == votes.reduce((a, b) => a > b ? a : b);
              final progress = totalVotes == 0 ? 0.0 : votes[index] / totalVotes;
              final isMyVote = hasVotedIndex == index;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Stack(
                  children: [
                    // Progress Bar background
                    Container(
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: isMyVote ? AppColors.primary : Colors.grey.withValues(alpha: 0.2)),
                      ),
                    ),
                    // Progress Fill
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: isTopChoice ? Colors.green.withValues(alpha: 0.2) : AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    // Content
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            if (isMyVote && !isClosed) const Icon(Icons.check_circle, color: AppColors.primary, size: 18),
                            if (isTopChoice) const Icon(Icons.workspace_premium, color: Colors.amber, size: 18),
                            if (isMyVote || isTopChoice) const SizedBox(width: 8),
                            Expanded(child: Text(options[index], style: AppTextStyles.labelMedium)),
                            Text('${votes[index]} votes', style: AppTextStyles.labelSmall),
                            const SizedBox(width: 8),
                            // Stacked Avatars mockup
                            if (votes[index] > 0)
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Stack(
                                  children: [
                                    Positioned(right: 0, child: CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${index+1}'))),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
