import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final String title;
  final String description;
  final Color titleColor;
  final Color bulletColor;

  const BulletPoint({
    super.key,
    required this.title,
    required this.description,
    this.titleColor = Colors.green,
    this.bulletColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use a Text widget for better alignment
          Text(
            "•",
            style: TextStyle(
              color: bulletColor,
              fontSize: 20, // Adjust the size to match the text height
              height: 1.2,  // Adjust the height to align with the text
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(color: titleColor, fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                  TextSpan(
                    text: description,
                    style: const TextStyle(color: Colors.black,fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
