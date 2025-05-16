import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silm_track_app_new/View/Authentication/login_page.dart';
import 'package:silm_track_app_new/utils/apis/apis.dart';

class Headersection extends StatelessWidget {
  const Headersection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Get.to(() => const PersonalInfo());
          },
          child: CircleAvatar(
            radius: 50,
            backgroundImage:
                Apis.user.photoURL != null
                    ? NetworkImage(Apis.user.photoURL.toString())
                    : const AssetImage("assets/images/user_image.png")
                        as ImageProvider,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Hello, ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 5),
                Text(
                  Apis.user.displayName.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text(
              "You are on your way to a good start",
              style: TextStyle(fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                Apis.auth.signOut();

                Get.to(() => const LoginPage());
              },
              child: const Text(
                "Logout",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
