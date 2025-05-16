// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';

class MyLoginSignUpTextField extends StatelessWidget {
  final String hintText;
  final obscureText;
  final TextEditingController controller;
  const MyLoginSignUpTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(
              color: AppColors.lite_green,
              width: 2,
            ), // default border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(
              color: AppColors.lite_green,
              width: 2,
            ), // enabled border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(
              color: AppColors.lite_green,
              width: 2,
            ), // focused border color
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please entter $hintText";
          } else if (value.length < 7) {
            return "Length should be greater than 6";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
