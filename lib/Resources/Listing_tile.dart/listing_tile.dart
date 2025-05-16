// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/Resources/Buttons/buy_and_cart_button.dart';

class ListingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  void Function()? ontapBuy;
  void Function()? ontapCart;
  final String image;
  final double price;
  ListingTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.ontapBuy,
    this.ontapCart,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: width * 0.90, // Adjust the width based on screen size
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
                  width: 80, // Adjust this value to increase the image size
                  height: 150, // Adjust this value to increase the image size
                  child: Image.asset(
                    image,
                    fit:
                        BoxFit
                            .contain, // You can also try BoxFit.cover or BoxFit.fill
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ), // Adjusted padding to prevent overflow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const Text(
                        "12 bags",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      const Spacer(), // Pushes the button to the bottom
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: BuyAndCartButton(
                              ontap: ontapBuy,
                              text: "Buy",
                            ),
                          ),
                          Expanded(
                            child: BuyAndCartButton(
                              ontap: ontapCart,
                              text: "Add to cart",
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
    );
  }
}
