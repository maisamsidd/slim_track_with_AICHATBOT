import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/Resources/Buttons/Animated_button.dart';
import 'package:silm_track_app_new/Resources/Buttons/profile_build_textfield.dart';
import 'package:silm_track_app_new/Resources/Text_Fields/profileTextFeild.dart';
import 'package:silm_track_app_new/View/HomePage/HomePage.dart';

class ProfileBuildPage extends StatefulWidget {
  const ProfileBuildPage({super.key});

  @override
  _ProfileBuildPageState createState() => _ProfileBuildPageState();
}

class _ProfileBuildPageState extends State<ProfileBuildPage> {
  final firestore = FirebaseFirestore.instance;
  final TextEditingController dateofBirthController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController targetWeightController = TextEditingController();

  String selectedGoal = 'Lose weight'; // Default goal

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final userId = auth.currentUser!.uid;
    final email = auth.currentUser!.email;
    final displayName = auth.currentUser!.displayName;
    final photoUrl = auth.currentUser!.photoURL;

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.lite_20_green,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.1),
              const Center(
                child: Text(
                  "Complete Your Profile",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Profiletextfeild(
                    hintText: "Date of birth",
                    controller: dateofBirthController,
                  ),
                  Profiletextfeild(
                    hintText: "Phone number",
                    controller: phoneNumberController,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Profiletextfeild(hintText: "Sex", controller: sexController),
                  Profiletextfeild(
                    hintText: "Height",
                    controller: heightController,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Profiletextfeild(
                    hintText: "Weight",
                    controller: weightController,
                  ),
                  Profiletextfeild(
                    hintText: "Target weight",
                    controller: targetWeightController,
                  ),
                ],
              ),
              const Text(
                "Goal",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lite_green,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGoal = 'Lose weight';
                      });
                    },
                    child: ProfileBuildTextButton(
                      text: "Lose weight",
                      isSelected: selectedGoal == 'Lose weight',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGoal = 'Maintain weight';
                      });
                    },
                    child: ProfileBuildTextButton(
                      text: "Maintain weight",
                      isSelected: selectedGoal == 'Maintain weight',
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.05),
              MyAnimatedButton(
                ontap: () {
                  firestore.collection("user").doc(userId).set({
                    "userId": userId,
                    "email": email,
                    "displayName": displayName,
                    "dateofBirth": dateofBirthController.text,
                    "phoneNumber": phoneNumberController.text,
                    "sex": sexController.text,
                    "height": heightController.text,
                    "weight": weightController.text,
                    "targetWeight": targetWeightController.text,
                    "goal": selectedGoal,
                    "currentWeight": "0",
                  });

                  Get.to(() => const Homepage());
                },
                firstText: "Continue",
                secondText: "Saving...",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
