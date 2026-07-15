import 'package:flutter/material.dart';

class SideLogo extends StatelessWidget {
  const SideLogo({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          children: [
            // Bold White J
            const TextSpan(
              text: "J",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),

            // Red Dot
            TextSpan(
              text: ".",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFF62440), // Same as Hire Me button
              ),
            ),

            // Joydeb Kumer
            TextSpan(
              text: " Joydeb Kumer",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.85),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}