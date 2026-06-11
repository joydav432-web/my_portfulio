import 'package:flutter/material.dart';
import 'package:my_portfulio/style/style.dart';
import 'package:my_portfulio/widgets/side_logo.dart';

import '../constants/colors.dart';
import '../constants/nav_item.dart';
class HeaderDesktop extends StatefulWidget {
  const HeaderDesktop({super.key});

  @override
  State<HeaderDesktop> createState() => _HeaderDesktopState();
}

class _HeaderDesktopState extends State<HeaderDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.00,vertical: 20.00),
      decoration:khHeaderDecoration,

      child: Row(
        children: [

          SideLogo(

            onTap: (){},
          ),

          Spacer(),

          for (int i =0; i<navTiles.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(onPressed: (){},
                child: Text(navTiles[i],
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: CustomColor.whitePrimary

                  ),
                ),),
            )

        ],
      ),
    );
  }
}
