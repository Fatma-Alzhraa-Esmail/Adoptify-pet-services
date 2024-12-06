import 'package:flutter/material.dart';

abstract class AppTextStyles {
  /// - weight: w100
  /// - family: inter
  /// - color: black `(default)`
  static const TextStyle w100 =
      TextStyle(fontWeight: FontWeight.w100, color: Colors.black);

  /// - weight: w200
  /// - family: inter
  /// - color: black `(default)`
  static const TextStyle w200 =
      TextStyle(fontWeight: FontWeight.w200, color: Colors.black);

  /// - weight: w300
  /// - family: inter
  /// - color: black `(default)`
  static const TextStyle w300 =
      TextStyle(fontWeight: FontWeight.w300, color: Colors.black);

  /// - weight: w400
  /// - family: inter
  /// - color: black `(default)`
  static const TextStyle w400 =
      TextStyle(fontWeight: FontWeight.w400, color: Colors.black);

  /// - weight: w500
  /// - family: inter
  /// - color: black `(default)`
  static const TextStyle w500 =
      TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16);

  /// - weight: w600
  /// - family: inter
  /// - color: black `(default)`
  static const TextStyle w600 = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.38,
      letterSpacing: 0.408);

  /// - weight: w700
  /// - family: inter
  /// - color: black `(default)`
  static const TextStyle w700 =
      TextStyle(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 26);

  /// - weight: w800
  /// - family: inter
  /// - color: black `(default)`
  static const TextStyle w800 =
      TextStyle(fontWeight: FontWeight.w800, color: Colors.black);

  /// - weight: w900
  /// - family: inter
  /// - color: black `(default)`
  static const TextStyle w900 =
      TextStyle(fontWeight: FontWeight.w900, color: Colors.black);
  static const TextStyle w600BoxShadow = TextStyle(
    overflow: TextOverflow.clip,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    shadows: [
      BoxShadow(
        color: Color.fromARGB(255, 36, 35, 35),
        blurRadius: 2,
        spreadRadius: 1,
        offset: Offset(0, 0.3),
      ),
    ],
  );
}
