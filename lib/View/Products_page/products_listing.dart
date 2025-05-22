import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silm_track_app_new/Model/product_listing.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/Resources/BottomNavBar/bottomnavbar.dart';
import 'package:silm_track_app_new/Resources/Buttons/buy_and_cart_button.dart';
import 'package:silm_track_app_new/View/Products_page/cart_listing.dart';
import 'package:silm_track_app_new/View/Products_page/item_info.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class ListingOfProducts extends StatefulWidget {
  const ListingOfProducts({super.key});

  @override
  State<ListingOfProducts> createState() => _ListingOfProductsState();
}

class _ListingOfProductsState extends State<ListingOfProducts> {
  @override
  Widget build(BuildContext context) {
    List<ProductListingModel> cartItems = [
      ProductListingModel(
        title: "Eclored ice",
        price: 27.99,
        fixedPrice: 27.99,
        subtitlee: "Milt Detox tea",
        image: "assets/images/tea_bag.png",
        bags: 1,
      ),
      ProductListingModel(
        title: "Eclored mint",
        price: 19.99,
        subtitlee: "Enjoy tea",
        fixedPrice: 17.99,
        image: "assets/images/tea_bag.png",
        bags: 1,
      ),
      ProductListingModel(
        title: "Eclored tea",
        fixedPrice: 17.99,
        price: 25.99,
        subtitlee: "Entence Detox tea",
        image: "assets/images/tea_bag.png",
        bags: 1,
      ),
      ProductListingModel(
        title: "Eclored tea",
        fixedPrice: 20.99,
        price: 23.99,
        subtitlee: "Eclore Detox Tea",
        image: "assets/images/tea_bag.png",
        bags: 1,
      ),
    ];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;

    return Scaffold(
      backgroundColor: AppColors.lite_20_green,
      appBar: AppBar(
        backgroundColor: AppColors.lite_20_green,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder(
              stream:
                  fireStore
                      .collection("cartItems")
                      .doc(userId)
                      .collection("items")
                      .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: AppColors.lite_green,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CartListing(),
                        ),
                      );
                    },
                  );
                }
                var itemCount = snapshot.data!.docs.length;

                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: AppColors.lite_green,
                        size: 22,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CartListing(),
                          ),
                        );
                      },
                    ),
                    if (itemCount > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            itemCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            const Center(
              child: Text(
                "Real results by real people",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  var title = cartItems[index].title.toString();
                  var subtitle = cartItems[index].subtitlee.toString();
                  var image = cartItems[index].image.toString();
                  var price = cartItems[index].price;
                  var bags = cartItems[index].bags;
                  var fixedPrice = cartItems[index].fixedPrice;

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ItemDetails(title: title, image: image));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: width * 0.90,
                        height: 200,
                        decoration: BoxDecoration(
                          color: AppColors.gray_color,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 30,
                                  horizontal: 10,
                                ),
                                child: SizedBox(
                                  width: 80,
                                  height: 150,
                                  child: Image.asset(
                                    image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      Text(
                                        subtitle,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      Text(
                                        "$bags bags",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: BuyAndCartButton(
                                              ontap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder:
                                                        (
                                                          BuildContext context,
                                                        ) => UsePaypal(
                                                          sandboxMode: true,
                                                          clientId:
                                                              "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                                                          secretKey:
                                                              "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                                                          returnURL:
                                                              "https://samplesite.com/return",
                                                          cancelURL:
                                                              "https://samplesite.com/cancel",
                                                          transactions: const [
                                                            {
                                                              "amount": {
                                                                "total":
                                                                    '10.12',
                                                                "currency":
                                                                    "USD",
                                                                "details": {
                                                                  "subtotal":
                                                                      '10.12',
                                                                  "shipping":
                                                                      '0',
                                                                  "shipping_discount":
                                                                      0,
                                                                },
                                                              },
                                                              "description":
                                                                  "The payment transaction description.",
                                                              "item_list": {
                                                                "items": [
                                                                  {
                                                                    "name":
                                                                        "A demo product",
                                                                    "quantity":
                                                                        1,
                                                                    "price":
                                                                        '10.12',
                                                                    "currency":
                                                                        "USD",
                                                                  },
                                                                ],
                                                                "shipping_address": {
                                                                  "recipient_name":
                                                                      "Jane Foster",
                                                                  "line1":
                                                                      "Travis County",
                                                                  "line2": "",
                                                                  "city":
                                                                      "Austin",
                                                                  "country_code":
                                                                      "US",
                                                                  "postal_code":
                                                                      "73301",
                                                                  "phone":
                                                                      "+00000000",
                                                                  "state":
                                                                      "Texas",
                                                                },
                                                              },
                                                            },
                                                          ],
                                                          note:
                                                              "Contact us for any questions on your order.",
                                                          onSuccess: (
                                                            Map params,
                                                          ) async {
                                                            print(
                                                              "onSuccess: $params",
                                                            );
                                                          },
                                                          onError: (error) {
                                                            print(
                                                              "onError: $error",
                                                            );
                                                          },
                                                          onCancel: (params) {
                                                            print(
                                                              'cancelled: $params',
                                                            );
                                                          },
                                                        ),
                                                  ),
                                                );
                                              },
                                              text: "Buy",
                                            ),
                                          ),
                                          Expanded(
                                            child: BuyAndCartButton(
                                              ontap: () async {
                                                final existingItem =
                                                    await fireStore
                                                        .collection("cartItems")
                                                        .doc(userId)
                                                        .collection("items")
                                                        .where(
                                                          "title",
                                                          isEqualTo: title,
                                                        )
                                                        .get();

                                                if (existingItem.docs.isEmpty) {
                                                  await fireStore
                                                      .collection("cartItems")
                                                      .doc(userId)
                                                      .collection("items")
                                                      .add({
                                                        "title": title,
                                                        "subtitle": subtitle,
                                                        "image": image,
                                                        "price": price,
                                                        "bags": bags,
                                                        "fixedPrice":
                                                            fixedPrice,
                                                      });
                                                  Get.snackbar(
                                                    "Success",
                                                    "Item added to cart",
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    duration: const Duration(
                                                      seconds: 2,
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                    colorText: Colors.white,
                                                  );
                                                } else {
                                                  Get.snackbar(
                                                    "Error",
                                                    "Item already in cart",
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    duration: const Duration(
                                                      seconds: 2,
                                                    ),
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                  );
                                                }
                                              },
                                              text: "Add to Cart",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
