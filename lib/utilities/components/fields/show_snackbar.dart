import 'package:adoptify/utilities/theme/media.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SnackbarComponent {
  static void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 5),
      backgroundColor:  HexColor('#5496ff'),
      width: MediaHelper.width,
      behavior: SnackBarBehavior.floating,


      
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}