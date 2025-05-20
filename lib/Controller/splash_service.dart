import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:silm_track_app_new/View/Authentication/login_page.dart';
import 'package:silm_track_app_new/View/HomePage/HomePage.dart';
import 'package:silm_track_app_new/View/ProfileCreationPage.dart';

class SplashService {
  static void splashService(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      Future.delayed(Duration(seconds: 3), () {
        print("User does not  Exists");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        print("User Exists");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      });
    }
  }
}
