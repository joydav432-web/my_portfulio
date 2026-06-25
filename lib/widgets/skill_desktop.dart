import 'package:flutter/material.dart';

import '../constants/skill_item.dart';

class SkillDesktop extends StatelessWidget {
  const SkillDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 450,
          ),
          child: Wrap(
            spacing: 20.0,
            runSpacing: 20.0,
            children: [
              for (int i = 0; i < platformItems.length; i++)
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1B3D),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.cyanAccent,
                      width: 3.0,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    leading: Image.asset(platformItems[i]["img"], width: 26),
                    title: Text(
                      platformItems[i]["title"],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
            ],
          ),
        ),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                for (int i = 0; i < skillItem.length; i++)
                  Chip(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    backgroundColor: const Color(0xFF0D1B3D),
                    label: Text(skillItem[i]["title"]),
                    avatar: Image.asset(skillItem[i]["img"]),
                    side: BorderSide(color: Colors.white24),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
