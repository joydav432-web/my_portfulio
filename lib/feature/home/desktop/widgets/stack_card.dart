import 'package:flutter/material.dart';

import 'hover_skill.dart';

class StackCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> skills;

  const StackCard({
    super.key,
    required this.icon,
    required this.title,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final iconSize = (width * .08).clamp(18.0, 24.0);
        final titleSize = (width * .05).clamp(12.0, 14.0);

        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: const Color(0xffAA2E1B), size: iconSize),

                  SizedBox(width: width * .03),

                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: width * .08),

              Wrap(
                spacing: 8,
                runSpacing: 12,
                children: List.generate(
                  skills.length,
                      (index) => HoverSkill(
                    text: index == skills.length - 1
                        ? skills[index]
                        : "${skills[index]} /",
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
