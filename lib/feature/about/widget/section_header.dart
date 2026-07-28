import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.label, required this.title});

  final String label;
  final String title;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final smallFont = (width * 0.011).clamp(10.0, 13.0);
        final titleFont = (width * 0.06).clamp(28.0, 44.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xffAA2E1B),
                    fontSize: smallFont,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(width: (width * 0.02).clamp(10.0, 20.0)),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFont,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ],
        );
      },
    );
  }
}



  