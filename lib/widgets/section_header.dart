import 'package:flutter/material.dart';
import '../constants/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text Animation: Fades in, slides up, and scales slightly
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1000),
          tween: Tween<double>(begin: 0, end: 1),
          curve: Curves.easeOutBack,
          builder: (context, double value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: Transform.scale(
                  scale: 0.95 + (0.05 * value),
                  child: child,
                ),
              ),
            );
          },
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Underline Animation: Grows from center with a glow effect
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 1400),
          tween: Tween<double>(begin: 0, end: 1),
          curve: Curves.easeInOutQuart,
          builder: (context, double value, child) {
            return Container(
              height: 4,
              width: 100 * value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffF62440),
                    CustomColor.yellowSecondary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffF62440).withOpacity(0.4 * value),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
