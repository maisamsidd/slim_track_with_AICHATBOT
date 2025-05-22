import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silm_track_app_new/View/Authentication/login_page.dart';
import 'package:silm_track_app_new/utils/apis/apis.dart';

class Headersection extends StatelessWidget {
  const Headersection({super.key});

  // Define custom colors
  static const Color liteGreen = Color(0xff35A63E);
  static const Color lite20Green = Color(0xffF8FFF8);
  static const Color grayColor = Color(0xffF1F4FF);

  @override
  Widget build(BuildContext context) {
    final currentUser = Apis.user;

    // Redirect to login if user is null
    if (currentUser == null) {
      Future.microtask(() {
        Get.offAll(() => const LoginPage());
      });
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [liteGreen.withOpacity(0.02), lite20Green, lite20Green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Avatar with animated scale effect
          GestureDetector(
            onTap: () {
              // Get.to(() => const PersonalInfo());
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.identity()..scale(1.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: liteGreen.withOpacity(0.4),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: liteGreen.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: grayColor,
                  backgroundImage:
                      currentUser.photoURL != null
                          ? NetworkImage(currentUser.photoURL!)
                          : const AssetImage("assets/images/user_image.png")
                              as ImageProvider,
                  child:
                      currentUser.photoURL == null
                          ? const Icon(Icons.person, size: 42, color: liteGreen)
                          : null,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          // User Info Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Hello, ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                    Text(
                      currentUser.displayName?.split(" ")[0] ?? "User",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: liteGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "You are on your way to a good start",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.color!.withOpacity(0.65),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () async {
                    await Apis.auth.signOut();
                    Get.offAll(() => const LoginPage());
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: liteGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: liteGreen.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
