import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/skill_item.dart';

class SkillsMobile extends StatelessWidget {
  const SkillsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 500.0
      ),
      child: Column(
          children: [

            for(int i = 0; i<platformItems.length;i++)
              Container(
                margin: EdgeInsets.only(bottom:5.00),
                width: double.maxFinite,

                decoration: BoxDecoration(
                  color: CustomColor.bgLight2,
                  borderRadius: BorderRadius.circular(5.0),


                ),

                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(

                    vertical: 10.00,
                    horizontal: 20.00,
                  ),
                  leading: Image.asset(platformItems[i]["img"],
                    width: 26,
                  ),
                  title: Text(platformItems[i]["title"]),

                ),
              ),


            SizedBox(
              height: 50,
            ),


            Wrap(
              spacing: 10.00,
              runSpacing: 10.00,

              alignment: WrapAlignment.center ,
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

            )
          ]
      ),
    );
  }
}
