import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';

class WeekDays extends StatelessWidget {
  const WeekDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDayColumn("Mon", "1"),
        _buildDayColumn("Tue", "2"),
        _buildDayColumn("Wed", "3"),
        _buildDayColumn("Thu", "4"),
        _buildDayColumn("Fri", "5"),
        _buildDayColumn("Sat", "6"),
        _buildDayColumn("Sun", "7"),
      ],
    );
  }

  Widget _buildDayColumn(String day, String number) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.lite_green,
          ),
        ),
        const SizedBox(height: 8),
        CircleAvatar(
          radius: 15, // Adjust the size of the circle
          backgroundColor: AppColors.lite_green,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
