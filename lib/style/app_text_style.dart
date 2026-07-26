import 'package:flutter/material.dart';
import 'package:my_portfulio/style/colors.dart';

class AppTextStyle {
  static TextStyle body(double size) {
    return TextStyle(
      color: CustomColor.text,
      fontSize: size,
      height: 1.6,
    );
  }

  static TextStyle title(double size) {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: size,
    );
  }

  static TextStyle small(double size) {
    return TextStyle(
      color: CustomColor.primary,
      letterSpacing: 3,
      fontSize: size,
      fontWeight: FontWeight.w600,
    );
  }
}