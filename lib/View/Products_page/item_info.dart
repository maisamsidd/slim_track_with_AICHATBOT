// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  String title;
  String image;

  ItemDetails({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              widget.image,
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'This is a sample paragraph in Flutter. You can style the text using different properties like font size, color, weight, and more. '
                'Flutter allows you to create multi-line text easily using the Text widget, and you can control alignment, overflow behavior, '
                'and other text features as needed.',
                style: TextStyle(fontSize: 16.0, height: 1.5),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
