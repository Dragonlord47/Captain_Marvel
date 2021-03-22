import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle subTitleWhite() {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle subTitleWhiteNB() {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    );
  }

  static TextStyle subTitleWhite2() {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle titleWhite() {
    return TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle titleWhite2() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle bodyBoldWhite() {
    return TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  static TextStyle bodyNormalWhite() {
    return TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    );
  }

  static TextStyle bodyType2Silver() {
    return TextStyle(
        fontSize: 13, fontWeight: FontWeight.bold, color: silver());
  }

  static Color silver() {
    return Color.fromRGBO(153, 153, 153, 1);
  }
}
