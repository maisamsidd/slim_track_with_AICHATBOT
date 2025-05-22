// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:lottie/lottie.dart';
// import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
// import 'package:silm_track_app_new/View/HomePage/HomePage.dart';
// import 'package:silm_track_app_new/View/Products_page/products_listing.dart';

// class Midsection extends StatefulWidget {
//   const Midsection({super.key});

//   @override
//   State<Midsection> createState() => _MidsectionState();
// }

// final currentWeightController = TextEditingController();
// final previousController = TextEditingController();
// final logController = TextEditingController();

// final fireStore = FirebaseFirestore.instance;
// final auth = FirebaseAuth.instance;
// Map<String, dynamic> _userInfo = {};

// class _MidsectionState extends State<Midsection> {
//   @override
//   Widget build(BuildContext context) {
//     Future<void> _fetchUserInfo() async {
//       try {
//         final userId = auth.currentUser!.uid;

//         DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
//             await FirebaseFirestore.instance
//                 .collection("user")
//                 .doc(userId)
//                 .get();

//         if (documentSnapshot.exists) {
//           setState(() {
//             _userInfo = documentSnapshot.data()!;
//           });
//         } else {
//           print('Document does not exist');
//         }
//       } catch (e) {
//         print('Error fetching user data: $e');
//       }
//     }

//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     final userId = auth.currentUser?.uid;

//     final userName = auth.currentUser?.displayName;
//     final userEmail = auth.currentUser?.email;
//     final image = auth.currentUser?.photoURL;

//     void logWeight() async {
//       await fireStore.collection("user").doc(userId).update({
//         "currentWeight": logController.text,
//       });
//     }

//     int currentWeight = int.parse(_userInfo['currentWeight'] ?? '0') ?? 0;
//     int previousWeight = int.parse(_userInfo['weight'] ?? '0');

//     Widget getArrow() {
//       if (currentWeight > previousWeight) {
//         return Container(
//           width: 100,
//           height: 100,
//           decoration: const BoxDecoration(),
//           child: Expanded(
//             child: Lottie.asset(
//               "assets/Animations/arrow_up.json",
//               fit: BoxFit.fill,
//             ),
//           ),
//         );
//       } else {
//         return SizedBox(
//           width: 100,
//           height: 100,
//           child: Lottie.asset("assets/Animations/arrow_down.json"),
//         );
//       }
//     }

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Flexible(
//             flex: 5,
//             child: Container(
//               height: 225,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(15),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 10,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'My Tracker',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       getArrow(),
//                       const SizedBox(width: 5),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Current weight',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                             SizedBox(
//                               width: 80,
//                               height: 40,
//                               child: Text(
//                                 _userInfo['currentWeight'] ?? "o",
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   color: AppColors.lite_green,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             const Text(
//                               'Previous weight',
//                               style: TextStyle(fontSize: 14),
//                             ),
//                             SizedBox(
//                               width: 80,
//                               height: 40,
//                               child: Text(
//                                 _userInfo['weight'] ?? "0",
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   color: AppColors.lite_green,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Flexible(
//             flex: 2,
//             child: Column(
//               children: [
//                 Container(
//                   height: 120,
//                   width: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 10,
//                         spreadRadius: 5,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 2),
//                       const Text(
//                         "Log Weight",
//                         style: TextStyle(color: AppColors.black, fontSize: 15),
//                       ),
//                       const SizedBox(height: 5),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: SizedBox(
//                           height: 40,
//                           child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             controller: logController,
//                             decoration: const InputDecoration(
//                               hintText: 'Type',
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter current weight';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.add),
//                         onPressed: () {
//                           fireStore.collection("user").doc(userId).update({
//                             "currentWeight": logController.text,
//                           });
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const HomePage(),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   height: 105,
//                   width: 120,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 10,
//                         spreadRadius: 5,
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         Get.to(() => const ListingOfProducts());
//                       },
//                       child: const Icon(
//                         Icons.shopping_cart,
//                         color: Colors.green,
//                         size: 40,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//     ;
//   }
// }
