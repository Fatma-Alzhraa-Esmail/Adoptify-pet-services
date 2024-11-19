import 'package:flutter/material.dart';
import 'colors.dart';

class DarkTheme implements ColorsTheme {
  @override
  Color borderColor = const Color(0xffE7E7E7);

  @override
  Color primary = Colors.black;

  @override
  Color secondery = Colors.black;

  @override
  Color inActive = Colors.red;

  @override
  Color greyTitle = const Color(0xff737373);

  @override
  Color background = Colors.white;

  @override
  Color error = const Color(0xffFFDA92);

  @override
  Color inactiveProgress = const Color(0xffE7E7E7);
}
