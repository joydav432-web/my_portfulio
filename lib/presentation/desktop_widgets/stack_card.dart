
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
    return SizedBox(
      width: MediaQuery.of(context).size.width<=600?double.infinity:260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Icon(
                icon,
                color: Color(0xffAA2E1B),
                size: 20,
              ),

              SizedBox(width: 10),

              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Wrap(
            spacing: 8,
            runSpacing: 14,
            children: List.generate(
              skills.length,
                  (index) => HoverSkill(
                text: index == skills.length - 1
                    ? skills[index]
                    : "${skills[index]} /",
              ),
            ),
          ),        ],
      ),
    );
  }
}

