import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';

class MonthlyPlans extends StatelessWidget {
  const MonthlyPlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(40),
      elevation: 10,
      child: Container(
        width: 390,
        height: 230,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.lite_green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(child: Image.asset("assets/images/tick.png")),
                  ),
                ),
                const SizedBox(width: 50),
                const Center(
                  child: Text(
                    "Monthly Plan",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.gray_color,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: Text(
                  "\$125",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 5),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.check_box_outlined, color: AppColors.lite_green),
                  SizedBox(width: 10),
                  Text(
                    "Unlimited access to all features",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.check_box_outlined, color: AppColors.lite_green),
                  SizedBox(width: 10),
                  Text(
                    "Unlimited access to all features",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.check_box_outlined, color: AppColors.lite_green),
                  SizedBox(width: 10),
                  Text(
                    "Unlimited access to all features",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
