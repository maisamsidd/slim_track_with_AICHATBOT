import 'package:flutter/material.dart';

class Dialogs {

  static void snackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),behavior: SnackBarBehavior.floating,));
      
    
}
static void showProgressBar(BuildContext context) {
    showDialog(context:context, builder: (_)=> const Center(child: CircularProgressIndicator()) );
      
    
}
}