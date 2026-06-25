import 'package:flutter/material.dart';

import '../constants/skill_item.dart';

class SkillsMobile extends StatelessWidget {
  const SkillsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500.0),
      child: Column(
        children: [
          for (int i = 0; i < platformItems.length; i++)
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: const Color(0xFF0D1B3D),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.cyanAccent.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0,
                ),
                leading: Image.asset(
                  platformItems[i]["img"],
                  width: 26,
                ),
                title: Text(
                  platformItems[i]["title"],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),

          const SizedBox(height: 50),

          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < skillItem.length; i++)
                Chip(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  backgroundColor: const Color(0xFF0D1B3D),
                  label: Text(skillItem[i]["title"]),
                  avatar: Image.asset(skillItem[i]["img"]),
                  side: const BorderSide(color: Colors.white24),
                )
            ],
          )
        ],
      ),
    );
  }
}
