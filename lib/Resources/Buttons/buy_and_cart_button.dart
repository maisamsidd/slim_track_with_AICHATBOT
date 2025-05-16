import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';

class BuyAndCartButton extends StatelessWidget {
  final String text;
  void Function()? ontap;
  BuyAndCartButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Container(
          width: 120, // Adjusted to match text fields
          height: 30, // You can adjust this to match the height you prefer
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.black),
            color: AppColors.lite_20_green,
            borderRadius: BorderRadius.circular(
              12,
            ), // Match the border radius with the text fields
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
