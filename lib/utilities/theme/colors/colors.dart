import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

abstract class ColorsTheme {
  late Color primary;
  late Color secondery;
  late Color borderColor;
  late Color inActive;
  late Color greyTitle;
  late Color background;
  late Color error;
  late Color inactiveProgress;

  static ColorsTheme themeMapper(ColorsThemeType value) {
    switch (value) {
      case ColorsThemeType.lightTheme:
        return LightTheme();
      case ColorsThemeType.darkTheme:
        return DarkTheme();
      default:
        return LightTheme();
    }
  }
}

enum ColorsThemeType { lightTheme, darkTheme }

final kTitleStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.black,
  fontSize: 18.0,
  height: 1.2,
);