import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/Resources/BottomNavBar/bottomnavbar.dart';
import 'package:silm_track_app_new/View/Authentication/login_page.dart';
import 'package:silm_track_app_new/View/Chatbot/chat_bot.dart';
import 'package:silm_track_app_new/View/HomePage/HeaderSection.dart';
import 'package:silm_track_app_new/View/HomePage/Week_days.dart';
import 'package:silm_track_app_new/View/Products_page/cart_listing.dart';
import 'package:silm_track_app_new/View/Products_page/products_listing.dart';
import 'package:silm_track_app_new/main.dart';
import 'package:silm_track_app_new/utils/apis/apis.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
        bottomNavigationBar: MyBottomNavBar(),
      ),
    );
  }
}
