import 'package:flutter/material.dart';

extension CustomTextStyle on TextStyle {
  TextStyle get headerText =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle get normalText =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  TextStyle get captionText => TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic);
}

class CustomColors {
  static Color get backgroundGrey => Color(0xffdddddd);
}
