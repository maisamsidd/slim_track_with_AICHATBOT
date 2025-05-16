import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:silm_track_app_new/View/HomePage/HomePage.dart';
import 'package:silm_track_app_new/main.dart';
import 'package:silm_track_app_new/utils/Dialogs/dialog.dart';
import 'package:silm_track_app_new/utils/apis/apis.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void googleSignInButton() async {
    Dialogs.showProgressBar(context);
    signInWithGoogle().then((user) async {
      if (user != null) {
        Navigator.pop(context);
        print(user.additionalUserInfo.toString());
        if (await Apis.userExist()) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        } else {
          Apis.createUser().then(
            (onValue) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Homepage()),
            ),
          );
        }
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await InternetAddress.lookup("google.com");
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("Error $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to SmitE's chat app")),
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            left: mq.width * .25,
            width: mq.width * .5,

            // child: Image.asset("assets/images/chat.png"),
            child: Icon(Icons.home),
          ),

          Positioned(
            top: mq.height * .7,
            left: mq.width * .1,

            child: TextButton(
              onPressed: () {
                googleSignInButton();
              },
              child: const Text(
                "Sign in with google",
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
