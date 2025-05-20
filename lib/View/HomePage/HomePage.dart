import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/Resources/BottomNavBar/bottomnavbar.dart';
import 'package:silm_track_app_new/View/Authentication/login_page.dart';
import 'package:silm_track_app_new/View/Chatbot/chat_bot.dart';
import 'package:silm_track_app_new/View/HomePage/HeaderSection.dart';
import 'package:silm_track_app_new/View/HomePage/MidSection.dart';
import 'package:silm_track_app_new/View/HomePage/Week_days.dart';
import 'package:silm_track_app_new/View/Products_page/products_listing.dart';
import 'package:silm_track_app_new/main.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final breakFastController = TextEditingController();
    final breakFastCaloriesController = TextEditingController();
    final lunchController = TextEditingController();
    final lunchCaloriesController = TextEditingController();
    final dinnerController = TextEditingController();
    final dinnerCaloriesController = TextEditingController();
    final snacksController = TextEditingController();
    final snacksCaloriesController = TextEditingController();
    final drinksController = TextEditingController();
    final drinksCaloriesController = TextEditingController();

    final fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    Map<String, dynamic> _userInfo = {};
    Map<String, dynamic> _userRoutine = {};
    final userId = auth.currentUser?.uid;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // if (userId == null) {
    //   // Delay the navigation to avoid issues with widget rebuilding
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Get.offAll(() => const LoginPage());
    //   });
    // }

    mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lite_20_green,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.lite_green,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(initialMessage: ""),
              ),
            );
          },
          child: Icon(Icons.chat_bubble, color: AppColors.white),
        ),
        body: Column(
          children: [
            const SizedBox(height: 25),
            Headersection(),
            const SizedBox(height: 20),
            const Week_days(),
            const SizedBox(height: 15),
            Midsection(),
          ],
        ),
        bottomNavigationBar: MyBottomNavBar(),
      ),
    );
  }
}
