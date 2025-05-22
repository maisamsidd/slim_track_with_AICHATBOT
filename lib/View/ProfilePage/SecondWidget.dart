// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';

class SecondWidget extends StatelessWidget {
  final String imagePath;
  final String maxCals;
  final String starWeirght;
  final String weightGoal;
  const SecondWidget({
    super.key,
    required this.imagePath,
    required this.maxCals,
    required this.starWeirght,
    required this.weightGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.lite_green),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Image(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                      width: 28, // Increased width
                      height: 28, // Increased height
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Flexible(
                  child: Text(
                    "Max Calories",
                    style: TextStyle(
                      color: AppColors.lite_green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    maxCals,
                    style: const TextStyle(
                      color: AppColors.lite_green,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, color: AppColors.lite_green),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Star weight",
                    style: TextStyle(
                      color: AppColors.lite_green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    "$starWeirght lb",
                    style: const TextStyle(
                      color: AppColors.lite_green,
                      fontSize: 16,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Weight goal",
                    style: TextStyle(
                      color: AppColors.lite_green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$weightGoal lb",
                    style: const TextStyle(
                      color: AppColors.lite_green,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
