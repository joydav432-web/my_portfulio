import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({
    super.key,
    this.hintText,
    this.controller,
    this.maxline = 1,
    this.validator,
  });

  final String? hintText;
  final TextEditingController? controller;
  final int? maxline;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxline,
      controller: controller,
      validator: validator,
      style: TextStyle(
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: CustomColor.whiteSecondary,
        contentPadding: const EdgeInsets.all(16),
        hintText: hintText,
        hintStyle: TextStyle(color: CustomColor.hintColor),

        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff03C4A1),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff03C4A1),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
        ),

        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffd00000),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}