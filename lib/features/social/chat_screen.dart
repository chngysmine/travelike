import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> contact;
  const ChatScreen({super.key, required this.contact});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)]),
                child: Row(
                  children: [
                    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20)),
                    const SizedBox(width: 12),
                    Stack(children: [
                      CircleAvatar(radius: 20, backgroundImage: CachedNetworkImageProvider(widget.contact['avatar'])),
                      Positioned(bottom: 0, right: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: AppColors.chipGreen, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)))),
                    ]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(widget.contact['name'], style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                        Text('Online', style: GoogleFonts.inter(fontSize: 12, color: AppColors.chipGreen)),
                      ]),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Iconsax.call, size: 20, color: AppColors.primary)),
                    IconButton(onPressed: () {}, icon: const Icon(Iconsax.video, size: 20, color: AppColors.primary)),
                  ],
                ),
              ).animate().fadeIn(duration: 300.ms),
              // Messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: MockData.chatMessages.length,
                  itemBuilder: (context, index) {
                    final msg = MockData.chatMessages[index];
                    final isMe = msg['sender'] == 'me';
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                        decoration: BoxDecoration(
                          color: isMe ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(18),
                            topRight: const Radius.circular(18),
                            bottomLeft: Radius.circular(isMe ? 18 : 4),
                            bottomRight: Radius.circular(isMe ? 4 : 18),
                          ),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          Text(msg['text'], style: GoogleFonts.inter(fontSize: 14, color: isMe ? Colors.white : AppColors.textPrimary, height: 1.4)),
                          const SizedBox(height: 4),
                          Text(msg['time'], style: GoogleFonts.inter(fontSize: 10, color: isMe ? Colors.white.withValues(alpha: 0.6) : AppColors.textTertiary)),
                        ]),
                      ),
                    ).animate().fadeIn(duration: 300.ms, delay: (index * 60).ms).slideY(begin: 0.05, end: 0);
                  },
                ),
              ),
              // Input
              Container(
                padding: EdgeInsets.fromLTRB(12, 8, 12, MediaQuery.of(context).padding.bottom + 8),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, -2))]),
                child: Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Iconsax.image, size: 22, color: AppColors.textTertiary)),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(24)),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(hintText: 'Type a message...', hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.textTertiary), border: InputBorder.none),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Iconsax.send_1, size: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
