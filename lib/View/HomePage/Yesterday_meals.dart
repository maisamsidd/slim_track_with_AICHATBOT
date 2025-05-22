// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';

class YesterdayMeals extends StatefulWidget {
  String meals;
  String cals;
  YesterdayMeals({super.key, required this.meals, required this.cals});

  @override
  State<YesterdayMeals> createState() => _YesterdayMealsState();
}

class _YesterdayMealsState extends State<YesterdayMeals> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        children: [
          const Text(
            'Previous meals:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.meals,
              style: const TextStyle(fontSize: 15, color: AppColors.lite_green),
            ),
          ),
          Text(
            "${widget.cals} Cals",
            style: const TextStyle(fontSize: 15, color: AppColors.lite_green),
          ),
        ],
      ),
    );
  }
}
