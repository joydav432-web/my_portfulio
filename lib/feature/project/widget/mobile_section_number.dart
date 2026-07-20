import 'package:flutter/material.dart';

class MobileSectionNumber extends StatelessWidget {
  final String number;

  const MobileSectionNumber({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Text(
        number,
        style: TextStyle(
          fontSize: 100,
          fontWeight: FontWeight.w900,
          height: 0.9,
          letterSpacing: -5,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.5
            ..color = Colors.white.withOpacity(.06),
        ),
      ),
    );
  }
}