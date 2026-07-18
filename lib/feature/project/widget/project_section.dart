import 'package:flutter/material.dart';

import 'desktop_section_number.dart';
import 'mobile_section_number.dart';

class ProjectSection extends StatelessWidget {
  final String number;
  final Widget child;

  const ProjectSection({
    super.key,
    required this.number,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          /// Background Number
          Positioned(
            top: -60,
            right: 0,
            child: isMobile
                ? MobileSectionNumber(number: number)
                : DesktopSectionNumber(number: number),
          ),

          /// Project Card
          child,
        ],
      ),
    );
  }
}