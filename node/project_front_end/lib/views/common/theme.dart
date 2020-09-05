import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: Colors.blueAccent,
  accentColor: Colors.blueAccent,
  iconTheme: IconThemeData(
    color: Color.fromRGBO(59, 68, 76, 1),
  ),
  cursorColor: Colors.blueAccent,
  scaffoldBackgroundColor: Color.fromRGBO(243, 247, 255, 1),
  canvasColor: Colors.transparent,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 25,
      color: Color.fromRGBO(100, 100, 100, 1),
    ),
    bodyText2: TextStyle(
      fontSize: 35,
      color: Colors.black,
      fontWeight: FontWeight.bold
    )
  )
);

class ColorsUI {
  static Color veryLightPurple = Color.fromRGBO(235, 238, 255, 1);
  static Color darkPurple = Color.fromRGBO(95, 108, 181, 1);
  static Color noteColor = Color.fromRGBO(253, 251, 190, 1);
  static Color lightPink = Color.fromRGBO(245, 246, 251, 1);
  static Color darkYellow =  Colors.yellow[700];
  static Color lightPurple = Color.fromRGBO(202, 198, 250, 1);
  static Color purple = Color.fromRGBO(117, 111, 255, 1);
  static Color lightRed = Color.fromRGBO(255, 209, 209, 1);
  static Color red = Color.fromRGBO(191, 0, 0, 1);
  static Color green = Color.fromRGBO(16, 172, 54, 1);
  static Color lightGreen = Color.fromRGBO(213, 253, 211, 1);
}
