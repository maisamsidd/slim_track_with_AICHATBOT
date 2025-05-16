import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/View/Authentication/login_page.dart';

class ProfileSummary extends StatefulWidget {
  const ProfileSummary({super.key});

  @override
  State<ProfileSummary> createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends State<ProfileSummary> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.lite_green,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(child: Image.asset("assets/images/user_image.png")),
          ),
          const SizedBox(width: 10),

          Column(
            children: [
              const Text(
                "Welcome, Maisam!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Text(
                "You are on your way to a good start",
                style: TextStyle(fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    auth.signOut();
                    Get.to(() => const LoginPage());
                  });
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
