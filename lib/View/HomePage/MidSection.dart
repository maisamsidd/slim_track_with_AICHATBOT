import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/Resources/BottomNavBar/bottomnavbar.dart';
import 'package:silm_track_app_new/View/Products_page/products_listing.dart';

class Midsection extends StatefulWidget {
  const Midsection({super.key});

  @override
  State<Midsection> createState() => _MidsectionState();
}

class _MidsectionState extends State<Midsection> {
  final TextEditingController logController = TextEditingController();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic> userInfo = {};
  String? get userId => auth.currentUser?.uid;

  @override
  void dispose() {
    logController.dispose();
    super.dispose();
  }

  Future<void> logWeight() async {
    // if (logController.text.isEmpty || userId == null) return;
    await fireStore.collection("user").doc(userId).update({
      "currentWeight": logController.text,
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyBottomNavBar()),
    );
  }

  Widget _getWeightArrow() {
    final currentWeight = int.tryParse(userInfo['currentWeight'] ?? '') ?? 0;
    final previousWeight = int.tryParse(userInfo['weight'] ?? '') ?? 0;

    return currentWeight > previousWeight
        ? Lottie.asset(
          "assets/Animations/arrow_up.json",
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        )
        : Lottie.asset(
          "assets/Animations/arrow_down.json",
          width: 100,
          height: 100,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Left Card - Weight Tracker
          Flexible(
            flex: 5,
            child: Container(
              height: 225,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Tracker',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _getWeightArrow(),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Current Weight
                            const Text(
                              'Current weight',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 80,
                              height: 40,
                              child: Text(
                                userInfo['currentWeight'] ?? "0",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.lite_green,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Previous Weight
                            const Text(
                              'Previous weight',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 80,
                              height: 40,
                              child: Text(
                                userInfo['weight'] ?? "0",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.lite_green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Right Column - Log Weight and Products
          Flexible(
            flex: 2,
            child: Column(
              children: [
                // Log Weight Card
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 2),
                      const Text(
                        "Log Weight",
                        style: TextStyle(color: AppColors.black, fontSize: 15),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: logController,
                            decoration: const InputDecoration(
                              hintText: 'Type',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: logWeight,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Products Card
                Container(
                  height: 85,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () => Get.to(() => const ListingOfProducts()),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: Colors.green,
                        size: 40,
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
