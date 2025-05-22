import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/Resources/BottomNavBar/bottomnavbar.dart';
import 'package:silm_track_app_new/View/Authentication/login_page.dart';
import 'package:silm_track_app_new/View/Chatbot/chat_bot.dart';
import 'package:silm_track_app_new/View/HomePage/HeaderSection.dart';
import 'package:silm_track_app_new/View/HomePage/Week_days.dart';
import 'package:silm_track_app_new/View/HomePage/Yesterday_meals.dart';
import 'package:silm_track_app_new/View/HomePage/log_entries.dart';
import 'package:silm_track_app_new/View/Products_page/products_listing.dart';
import 'package:silm_track_app_new/View/ProfilePage/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // controllers for bottom
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
  // controllers for mid
  final currentWeightController = TextEditingController();
  final previousController = TextEditingController();
  final logController = TextEditingController();

  final fireStore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Map<String, dynamic> _userInfo = {};
  Map<String, dynamic> _userRoutine = {};

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
    _fetchUserRoutine();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchUserRoutine() async {
    try {
      final userId = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await fireStore.collection("routine_foods").doc(userId).get();

      if (documentSnapshot.exists) {
        setState(() {
          _userRoutine = documentSnapshot.data()!;
        });
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _fetchUserInfo() async {
    try {
      final userId = auth.currentUser!.uid;

      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance.collection("user").doc(userId).get();

      if (documentSnapshot.exists) {
        setState(() {
          _userInfo = documentSnapshot.data()!;
        });
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final userId = auth.currentUser?.uid;

    final userName = auth.currentUser?.displayName;
    final userEmail = auth.currentUser?.email;
    final image = auth.currentUser?.photoURL;

    if (userId == null) {
      // Delay the navigation to avoid issues with widget rebuilding
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(() => const LoginPage());
      });
    }

    void logWeight() async {
      await fireStore.collection("user").doc(userId).update({
        "currentWeight": logController.text,
      });
    }

    int currentWeight = int.parse(_userInfo['currentWeight'] ?? '0') ?? 0;
    int previousWeight = int.parse(_userInfo['weight'] ?? '0');

    Widget getArrow() {
      if (currentWeight > previousWeight) {
        return Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(),
          child: Expanded(
            child: Lottie.asset(
              "assets/Animations/arrow_up.json",
              fit: BoxFit.fill,
            ),
          ),
        );
      } else {
        return SizedBox(
          width: 100,
          height: 100,
          child: Lottie.asset("assets/Animations/arrow_down.json"),
        );
      }
    }

    return Scaffold(
      backgroundColor: AppColors.lite_20_green,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              Headersection(),
              const SizedBox(height: 20),
              const Week_days(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
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
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                getArrow(),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Current weight',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        height: 40,
                                        child: Text(
                                          _userInfo['currentWeight'] ?? "o",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: AppColors.lite_green,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Previous weight',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(
                                        width: 80,
                                        height: 40,
                                        child: Text(
                                          _userInfo['weight'] ?? "0",
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
                    Flexible(
                      flex: 2,
                      child: Column(
                        children: [
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
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: logController,
                                      decoration: const InputDecoration(
                                        hintText: 'Type',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter current weight';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    fireStore
                                        .collection("user")
                                        .doc(userId)
                                        .update({
                                          "currentWeight": logController.text,
                                        });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 105,
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
                                onTap: () {
                                  Get.to(() => const ListingOfProducts());
                                },
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
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Reminders",
                    style: TextStyle(color: AppColors.black, fontSize: 30),
                  ),
                ),
              ),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: width * 0.95,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Today's log entries",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      LogEntriesHome(
                        onPressed: () {
                          fireStore
                              .collection("routine_foods")
                              .doc(userId)
                              .set({
                                'breakfast':
                                    breakFastController.text.isEmpty
                                        ? "none"
                                        : breakFastController.text,
                                'caloriesBreakFast':
                                    breakFastCaloriesController.text.isEmpty
                                        ? "0"
                                        : breakFastCaloriesController.text,
                              }, SetOptions(merge: true));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        text: "Breakfast",
                        foodController: breakFastController,
                        calController: breakFastCaloriesController,
                      ),
                      YesterdayMeals(
                        meals: _userRoutine['breakfast'] ?? 'None',
                        cals: _userRoutine['caloriesBreakFast'] ?? '0',
                      ),
                      const SizedBox(height: 10),
                      LogEntriesHome(
                        onPressed: () {
                          fireStore
                              .collection("routine_foods")
                              .doc(userId)
                              .set({
                                'lunch': lunchController.text ?? "none",
                                'caloriesLunch':
                                    lunchCaloriesController.text ?? "0",
                              }, SetOptions(merge: true));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        text: "Lunch",
                        foodController: lunchController,
                        calController: lunchCaloriesController,
                      ),
                      YesterdayMeals(
                        meals: _userRoutine['lunch'] ?? 'None',
                        cals: _userRoutine['caloriesLunch'] ?? '0',
                      ),
                      const SizedBox(height: 10),
                      LogEntriesHome(
                        onPressed: () {
                          fireStore
                              .collection("routine_foods")
                              .doc(userId)
                              .set({
                                'dinner': dinnerController.text ?? "none",
                                'dinnersCalories':
                                    dinnerCaloriesController.text ?? "0",
                              }, SetOptions(merge: true));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        text: "Dinner",
                        foodController: dinnerController,
                        calController: dinnerCaloriesController,
                      ),
                      YesterdayMeals(
                        meals: _userRoutine['dinner'] ?? 'None',
                        cals: _userRoutine['caloriesDinner'] ?? '0',
                      ),
                      const SizedBox(height: 10),
                      LogEntriesHome(
                        onPressed: () {
                          fireStore
                              .collection("routine_foods")
                              .doc(userId)
                              .set({
                                "snacks": snacksController.text ?? "none",
                                "caloriesSnacks":
                                    snacksCaloriesController.text ?? "0",
                              }, SetOptions(merge: true));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        text: "Snacks",
                        foodController: snacksController,
                        calController: snacksCaloriesController,
                      ),
                      YesterdayMeals(
                        meals: _userRoutine['snacks'] ?? 'None',
                        cals: _userRoutine['caloriesSnacks'] ?? '0',
                      ),
                      const SizedBox(height: 10),
                      LogEntriesHome(
                        onPressed: () {
                          fireStore.collection("user").doc(userId).set({
                            "drinks": drinksController.text ?? "none",
                            "caloriesDrinks":
                                drinksCaloriesController.text ?? "0",
                          }, SetOptions(merge: true));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        text: "Drinks",
                        foodController: drinksController,
                        calController: drinksCaloriesController,
                      ),
                      YesterdayMeals(
                        meals: _userRoutine['drinks'] ?? 'None',
                        cals: _userRoutine['caloriesDrinks'] ?? '0',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(initialMessage: ""),
            ),
          );
        },
        backgroundColor: AppColors.lite_green,
        child: const Icon(Icons.chat_bubble, color: AppColors.white),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
