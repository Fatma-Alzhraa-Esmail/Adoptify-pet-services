import 'package:flutter/material.dart';
import 'colors.dart';

class LightTheme implements ColorsTheme {
  @override
  Color borderColor = Color.fromARGB(255, 172, 172, 172);

  @override
  Color primary = Colors.black;

  @override
  Color secondery = Colors.black;

  @override
  Color inActive = Colors.red;

  @override
  Color greyTitle = Color(0xff737373);
 @override
  Color greyTitle1 = Colors.grey.shade700;
  @override
  Color background = Colors.white;

  @override
  Color error = const Color(0xffF70000);

  @override
  Color inactiveProgress = const Color(0xffE7E7E7);

  Color mainColor = Color(0xFFffb200);
  Color redColor = Color(0xFFe44b3f);
  Color blueColor = Color(0xFF395a97);

}
