import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_background.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final List<String> _selectedSeats = [];
  final List<String> _bookedSeats = ['2A', '2B', '5C', '5D', '6A', '8F'];

  void _toggleSeat(String seat) {
    if (_bookedSeats.contains(seat)) return;
    setState(() {
      if (_selectedSeats.contains(seat)) {
        _selectedSeats.remove(seat);
      } else {
        _selectedSeats.add(seat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            children: [
              Text('SGN ➔ HAN', style: AppTextStyles.titleMedium),
              Text('Vietnam Airlines VN218', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
        body: Column(
          children: [
            // Status Legend
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem(AppColors.primary, 'Selected'),
                  _buildLegendItem(Colors.white.withValues(alpha: 0.1), 'Available'),
                  _buildLegendItem(Colors.redAccent, 'Unavailable'),
                ],
              ),
            ),

            // Plane Body Frame
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(100)),
                  border: Border.all(color: Colors.white12, width: 2),
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: 80, bottom: 100), // Cockpit space
                  itemCount: 15,
                  itemBuilder: (context, rowIndex) {
                    final row = rowIndex + 1;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSeat('$row${'A'}'),
                          _buildSeat('$row${'B'}'),
                          _buildSeat('$row${'C'}'),
                          const SizedBox(width: 32), // Aisle
                          SizedBox(width: 30, child: Center(child: Text('$row', style: AppTextStyles.labelSmall.copyWith(color: AppColors.textTertiary)))),
                          const SizedBox(width: 32), // Aisle
                          _buildSeat('$row${'D'}'),
                          _buildSeat('$row${'E'}'),
                          _buildSeat('$row${'F'}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Bottom Action Bar
            GlassContainer.solid(
              padding: const EdgeInsets.all(20),
              borderRadius: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selected: ${_selectedSeats.isEmpty ? 'None' : _selectedSeats.join(', ')}', style: AppTextStyles.labelMedium),
                      const SizedBox(height: 4),
                      Text('${_selectedSeats.length * 150000} VND', style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _selectedSeats.isEmpty ? null : () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Confirm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 8),
        Text(label, style: AppTextStyles.labelSmall),
      ],
    );
  }

  Widget _buildSeat(String seatId) {
    bool isBooked = _bookedSeats.contains(seatId);
    bool isSelected = _selectedSeats.contains(seatId);
    
    return GestureDetector(
      onTap: () => _toggleSeat(seatId),
      child: Container(
        width: 36,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : (isBooked ? Colors.redAccent.withValues(alpha: 0.3) : Colors.white.withValues(alpha: 0.1)),
          border: Border.all(color: isSelected ? AppColors.primary : (isBooked ? Colors.redAccent : Colors.white24)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
        ),
        child: Center(
          child: Text(
            isBooked ? 'X' : seatId,
            style: TextStyle(
              color: isBooked ? Colors.redAccent : (isSelected ? Colors.white : Colors.white54),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
