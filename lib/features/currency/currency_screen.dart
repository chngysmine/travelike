import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String _fromCurrency = 'USD';
  double _amount = 100;
  final _controller = TextEditingController(text: '100');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fromData = MockData.currencies.firstWhere((c) => c['code'] == _fromCurrency);
    final vndAmount = _amount * (fromData['rate'] as double);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios_new, size: 20)),
                    const SizedBox(width: 12),
                    Text('Currency Exchange', style: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700)),
                  ],
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 24),
                // Converter Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF667eea), Color(0xFF764ba2)]),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: const Color(0xFF667eea).withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8))],
                  ),
                  child: Column(children: [
                    // From
                    Row(children: [
                      Text(fromData['flag'] as String, style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Expanded(child: DropdownButtonHideUnderline(child: DropdownButton<String>(
                        value: _fromCurrency,
                        dropdownColor: const Color(0xFF764ba2),
                        items: MockData.currencies.map((c) => DropdownMenuItem(value: c['code'] as String, child: Text('${c['code']} - ${c['name']}', style: GoogleFonts.inter(fontSize: 14, color: Colors.white)))).toList(),
                        onChanged: (v) => setState(() => _fromCurrency = v!),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      ))),
                    ]),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _controller,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w300, color: Colors.white),
                      decoration: InputDecoration(
                        prefixText: '${fromData['symbol']}  ',
                        prefixStyle: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w300, color: Colors.white.withValues(alpha: 0.7)),
                        border: InputBorder.none,
                      ),
                      onChanged: (v) => setState(() => _amount = double.tryParse(v) ?? 0),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.swap_vert_rounded, color: Colors.white, size: 24),
                    ),
                    const SizedBox(height: 8),
                    // To VND
                    Row(children: [
                      const Text('🇻🇳', style: TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Text('VND - Vietnamese Dong', style: GoogleFonts.inter(fontSize: 14, color: Colors.white.withValues(alpha: 0.8))),
                    ]),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '₫ ${_formatVND(vndAmount)}',
                        style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w300, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('1 $_fromCurrency = ${_formatVND(fromData['rate'] as double)} VND', style: GoogleFonts.inter(fontSize: 12, color: Colors.white.withValues(alpha: 0.6))),
                    ),
                  ]),
                ).animate().fadeIn(duration: 500.ms, delay: 100.ms).slideY(begin: 0.05, end: 0),
                const SizedBox(height: 28),
                Text('Exchange Rates', style: GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                ...MockData.currencies.asMap().entries.map((entry) {
                  final c = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6)]),
                    child: Row(children: [
                      Text(c['flag'] as String, style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(c['code'] as String, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                        Text(c['name'] as String, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textTertiary)),
                      ])),
                      Text('${_formatVND(c['rate'] as double)} ₫', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    ]),
                  ).animate().fadeIn(duration: 300.ms, delay: (200 + entry.key * 50).ms);
                }),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatVND(double value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(value % 1000 == 0 ? 0 : 1)}K';
    return value.toStringAsFixed(0);
  }
}
