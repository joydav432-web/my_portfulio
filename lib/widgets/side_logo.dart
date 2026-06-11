import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SideLogo extends StatelessWidget {
  const SideLogo({super.key, this.onTap});
   final VoidCallback?onTap;


   @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Text("JOY",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: CustomColor.yellowSecondary
        ),
      ),
    );
  }
}
