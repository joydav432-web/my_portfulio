import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/nav_item.dart';

class DrawerMobile extends StatelessWidget {
  const DrawerMobile({super.key, required this.onNavItemTap});

  final Function (int) onNavItemTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        children: [

          for(int i=0; i<navTiles.length;i++)
            ListTile(

              contentPadding: EdgeInsets.symmetric(
                  horizontal: 30
              ),
              titleTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.whitePrimary
              ),
              leading: Icon(navItem[i]),
              title: Text(navTiles[i]),


              onTap: (){
                onNavItemTap(i);

              },


            ),

          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.clear))


        ],
      ),


    );
  }
}