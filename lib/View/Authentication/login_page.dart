import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/View/HomePage/HomePage.dart';
import 'package:silm_track_app_new/View/ProfileCreationPage.dart';
import 'package:silm_track_app_new/utils/Dialogs/dialog.dart';
import 'package:silm_track_app_new/utils/apis/apis.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size mq;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Slim Track App",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 40),
              Image.asset("assets/images/splash_image.png"),
              const SizedBox(height: 60),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  minimumSize: Size(mq.width * 0.8, 50),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: googleSignInButton,
                icon: const Icon(Icons.login_rounded, size: 28),
                label: const Text(
                  "Sign in with Google",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Sign in logic
  void googleSignInButton() async {
    Dialogs.showProgressBar(context);
    UserCredential? user = await signInWithGoogle();
    Navigator.pop(context);

    if (user != null) {
      if (await Apis.userExist()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        await Apis.createUser();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileBuildPage()),
        );
      }
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Check internet
      await InternetAddress.lookup("google.com");

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }
}
