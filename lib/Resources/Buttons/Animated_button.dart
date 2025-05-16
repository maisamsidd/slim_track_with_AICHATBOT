// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:silm_track_app_new/Resources/App_colors.dart/app_colors.dart';

class MyAnimatedButton extends StatefulWidget {
  String firstText;
  String secondText;
  void Function() ontap;

  MyAnimatedButton({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.ontap,
  });

  @override
  State<MyAnimatedButton> createState() => _MyAnimatedButtonState();
}

class _MyAnimatedButtonState extends State<MyAnimatedButton> {
  bool isSignedin = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.ontap,
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        width: isSignedin ? width * 0.4 : width * 0.87,
        height: height * 0.07,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),

          color: AppColors.lite_green,
        ),
        child: Center(
          child: Text(
            isSignedin ? widget.secondText : widget.firstText,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
