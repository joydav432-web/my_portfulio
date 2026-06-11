
 import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/skill_item.dart';

class SkillDesktop extends StatelessWidget {
  const SkillDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 450,
          ),
          child: Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: [

              for (int i = 0;i<platformItems.length; i++)
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: CustomColor.bgLight2,
                    borderRadius: BorderRadius.circular(5),

                  ),

                  child: ListTile(

                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0
                    ),
                    leading: Image.asset(platformItems[i]["img"]),
                    title: Text(platformItems[i]["title"]),
                  ),

                )
            ],
          ),
        ),



        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 500
            ),
            child: Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                for(int i = 0; i<skillItem.length;i++)
                  Chip(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    label: Text(skillItem[i]["title"]),
                    avatar: Image.asset(skillItem[i]["img"]),
                  )
              ],
            ),
          ),
        )
      ],
    )
    ;
  }
}
