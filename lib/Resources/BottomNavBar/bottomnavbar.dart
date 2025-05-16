import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';
import 'package:silm_track_app_new/View/HomePage/HomePage.dart';
import 'package:silm_track_app_new/View/Products_page/cart_listing.dart';
import 'package:silm_track_app_new/View/Products_page/products_listing.dart';
import 'package:silm_track_app_new/main.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: mq.height * 0.05,
        width: mq.width * 0.08,
        decoration: BoxDecoration(
          color: AppColors.lite_green,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepage()),
                );
              },
              icon: const Icon(Icons.home, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListingOfProducts(),
                  ),
                );
              },
              icon: const Icon(Icons.coffee, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartListing()),
                );
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartListing()),
                );
              },
              icon: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
