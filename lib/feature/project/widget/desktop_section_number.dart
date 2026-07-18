import 'package:flutter/material.dart';

class DesktopSectionNumber extends StatelessWidget {
  final String number;

  const DesktopSectionNumber({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Text(
        number,
        style: TextStyle(
          fontSize: 220,
          fontWeight: FontWeight.w900,
          color: Colors.transparent,
          height: 0.9,
          letterSpacing: -10,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.white.withOpacity(.08),
        ),
      ),
    );
  }
}