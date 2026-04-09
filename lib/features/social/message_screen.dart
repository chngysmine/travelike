import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/page_transitions.dart';
import '../../data/mock_data.dart';
import 'chat_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20)),
                    const SizedBox(width: 12),
                    Text('Message', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Iconsax.edit, size: 18, color: Colors.white),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms),
              // Stories
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final isFirst = index == 0;
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(children: [
                        Container(
                          width: 58, height: 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: isFirst ? null : Border.all(color: AppColors.primaryLight, width: 2),
                            color: isFirst ? AppColors.primarySurface : null,
                          ),
                          child: isFirst
                              ? const Icon(Icons.add, color: AppColors.primary, size: 24)
                              : ClipOval(child: CachedNetworkImage(imageUrl: MockData.messages[index]['avatar'], fit: BoxFit.cover)),
                        ),
                        const SizedBox(height: 6),
                        Text(isFirst ? 'Your story' : MockData.messages[index]['name'].toString().split(' ')[0], style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ]),
                    );
                  },
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
              const SizedBox(height: 8),
              // Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)]),
                  child: Row(
                    children: [
                      const Icon(Iconsax.search_normal, size: 20, color: AppColors.textTertiary),
                      const SizedBox(width: 12),
                      Expanded(child: TextField(decoration: InputDecoration(hintText: 'Search', hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.textTertiary), border: InputBorder.none, enabledBorder: InputBorder.none, focusedBorder: InputBorder.none))),
                    ],
                  ),
                ),
              ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
              const SizedBox(height: 16),
              // Message list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: MockData.messages.length,
                  itemBuilder: (context, index) {
                    final msg = MockData.messages[index];
                    final hasUnread = (msg['unread'] as int) > 0;
                    return GestureDetector(
                      onTap: () => Navigator.push(context, PageTransitions.slideRight(ChatScreen(contact: msg))),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: hasUnread ? AppColors.primarySurface : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          leading: Stack(children: [
                            CircleAvatar(radius: 26, backgroundImage: CachedNetworkImageProvider(msg['avatar'])),
                            if (msg['online'] == true) Positioned(bottom: 0, right: 0, child: Container(width: 14, height: 14, decoration: BoxDecoration(color: AppColors.chipGreen, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)))),
                          ]),
                          title: Text(msg['name'], style: GoogleFonts.inter(fontSize: 15, fontWeight: hasUnread ? FontWeight.w700 : FontWeight.w500, color: AppColors.textPrimary)),
                          subtitle: Text(msg['message'], maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontSize: 13, color: hasUnread ? AppColors.textPrimary : AppColors.textTertiary)),
                          trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(msg['time'], style: GoogleFonts.inter(fontSize: 11, color: hasUnread ? AppColors.primary : AppColors.textTertiary)),
                            if (hasUnread) ...[
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                                child: Text('${msg['unread']}', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white)),
                              ),
                            ],
                          ]),
                        ),
                      ),
                    ).animate().fadeIn(duration: 300.ms, delay: (index * 50).ms);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
