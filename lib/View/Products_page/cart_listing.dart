import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silm_track_app_new/Model/cart_model.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/Resources/Buttons/Animated_button.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class CartListing extends StatefulWidget {
  const CartListing({super.key});

  @override
  State<CartListing> createState() => _CartListingState();
}

class _CartListingState extends State<CartListing> {
  final auth = FirebaseAuth.instance;

  final double taxRate = 0.05; // 10% tax
  final double shippingFee = 7.98;
  double subtotal = 0.0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final userId = auth.currentUser!.uid;
    final cartItemsStream =
        FirebaseFirestore.instance
            .collection("cartItems")
            .doc(userId)
            .collection("items")
            .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: AppColors.lite_20_green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: cartItemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final cartItems =
                snapshot.data!.docs.map((doc) {
                  return {
                    "id": doc.id,
                    "model": CartModel(
                      title: doc['title'],
                      price: doc['price'],
                      image: doc['image'],
                      subtitle: doc['subtitle'],
                      quantity: doc['bags'],
                      fixedPrice: doc['fixedPrice'],
                    ),
                  };
                }).toList();

            // Calculate subtotal
            subtotal = 0.0;
            for (var item in cartItems) {
              var cartItem = item['model'] as CartModel;
              subtotal += cartItem.fixedPrice! * cartItem.quantity!;
            }

            double tax = subtotal * taxRate;
            double total = subtotal + tax + shippingFee;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      var cartItem = cartItems[index]['model'] as CartModel;
                      var documentId = cartItems[index]['id'] as String;

                      void increaseQuantity(int quantity, double price) async {
                        final docRef = FirebaseFirestore.instance
                            .collection("cartItems")
                            .doc(userId)
                            .collection("items")
                            .doc(documentId);

                        final docSnapshot = await docRef.get();

                        if (docSnapshot.exists) {
                          await docRef.update({
                            'bags': quantity + 1,
                            'price': price * 2,
                          });
                        } else {
                          Get.snackbar(
                            "Error",
                            "Item not found in the cart.",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      }

                      void deleteItem() {
                        FirebaseFirestore.instance
                            .collection("cartItems")
                            .doc(userId)
                            .collection("items")
                            .doc(documentId)
                            .delete();
                      }

                      void decreaseQuantity(int quantity, double price) async {
                        final docRef = FirebaseFirestore.instance
                            .collection("cartItems")
                            .doc(userId)
                            .collection("items")
                            .doc(documentId);

                        final docSnapshot = await docRef.get();

                        if (docSnapshot.exists) {
                          if (quantity > 1) {
                            await docRef.update({
                              'bags': quantity - 1,
                              "price": price / 2,
                            });
                          } else {
                            Get.snackbar(
                              "Notice",
                              "Quantity cannot be less than 12.",
                              backgroundColor: Colors.yellow,
                              colorText: Colors.black,
                            );
                          }
                        } else {
                          Get.snackbar(
                            "Error",
                            "Item not found in the cart.",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            width: width * 0.9,
                            height: 190,
                            decoration: BoxDecoration(
                              color: AppColors.gray_color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        child: SizedBox(
                                          width: 110,
                                          height: 110,
                                          child: Image.asset(
                                            cartItem.image.toString(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    cartItem.title.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              cartItem.subtitle.toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 15,
                                                  ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      decreaseQuantity(
                                                        cartItem.quantity!,
                                                        cartItem.price!,
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      size: 40,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    cartItem.quantity
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 25,
                                                      color:
                                                          AppColors.lite_green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      increaseQuantity(
                                                        cartItem.quantity!,
                                                        cartItem.price!,
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.add_circle_outline,
                                                      size: 40,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 40),
                                                  // Text(
                                                  //   cartItem.price!.toStringAsFixed(2).toString(),
                                                  //   style: const TextStyle(
                                                  //     fontSize: 25,
                                                  //     color: AppColors.black,
                                                  //     fontWeight: FontWeight.bold,
                                                  //   ),
                                                  // ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      deleteItem();
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ],
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
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.41,
                  width: width * 0.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Subtotal:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${subtotal.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tax:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${tax.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Shipping:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${shippingFee.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total:",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${total.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MyAnimatedButton(
                        ontap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (BuildContext context) => UsePaypal(
                                    sandboxMode: true,
                                    clientId:
                                        "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
                                    secretKey:
                                        "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
                                    returnURL: "https://samplesite.com/return",
                                    cancelURL: "https://samplesite.com/cancel",
                                    transactions: const [
                                      {
                                        "amount": {
                                          "total": '10.12',
                                          "currency": "USD",
                                          "details": {
                                            "subtotal": '10.12',
                                            "shipping": '0',
                                            "shipping_discount": 0,
                                          },
                                        },
                                        "description":
                                            "The payment transaction description.",
                                        // "payment_options": {
                                        //   "allowed_payment_method":
                                        //       "INSTANT_FUNDING_SOURCE"
                                        // },
                                        "item_list": {
                                          "items": [
                                            {
                                              "name": "A demo product",
                                              "quantity": 1,
                                              "price": '10.12',
                                              "currency": "USD",
                                            },
                                          ],

                                          // shipping address is not required though
                                          "shipping_address": {
                                            "recipient_name": "Jane Foster",
                                            "line1": "Travis County",
                                            "line2": "",
                                            "city": "Austin",
                                            "country_code": "US",
                                            "postal_code": "73301",
                                            "phone": "+00000000",
                                            "state": "Texas",
                                          },
                                        },
                                      },
                                    ],
                                    note:
                                        "Contact us for any questions on your order.",
                                    onSuccess: (Map params) async {
                                      print("onSuccess: $params");
                                    },
                                    onError: (error) {
                                      print("onError: $error");
                                    },
                                    onCancel: (params) {
                                      print('cancelled: $params');
                                    },
                                  ),
                            ),
                          );
                        },
                        firstText: "Proceed",
                        secondText: "Please wait..",
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("No items in your cart"));
          }
        },
      ),
    );
  }
}
