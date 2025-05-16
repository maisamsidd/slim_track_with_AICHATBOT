import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';

class ProfileBuildTextButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  const ProfileBuildTextButton({
    super.key,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Container(
          width: 160, // Adjusted to match text fields
          height: 60, // You can adjust this to match the height you prefer
          decoration: BoxDecoration(
            color: AppColors.gray_color,
            borderRadius: BorderRadius.circular(
              40,
            ), // Match the border radius with the text fields
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
