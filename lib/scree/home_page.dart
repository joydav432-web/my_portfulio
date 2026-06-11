import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_portfulio/constants/colors.dart';
import 'package:my_portfulio/widgets/drawer_mobile.dart';
import 'package:my_portfulio/widgets/header_mobile.dart';
import 'package:my_portfulio/widgets/partial_data.dart';
import 'package:my_portfulio/widgets/theme_home.dart' hide PulseRing;

import '../widgets/header_desktop.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scaffoldKey  = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {


    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return LayoutBuilder(
      builder: (context , Constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.scaffoldBg,


          endDrawer: Constraints.maxWidth>=600?null:const DrawerMobile(),

          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              //main

              if(Constraints.maxWidth>=600)
               const HeaderDesktop()else

                 HeaderMobile(
                onMenuTap: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
                onLogoTap: () {},

              ),

              ParticleBackground(
                child: const PartialData()
              ),






              //skills
              Container(
                height: 500,
                width: double.maxFinite,
                color: Colors.blueGrey,
              ),


              //project

              Container(
                height: 500,
                width: double.maxFinite,
              ),


              //contact
              Container(
                height: 500,
                width: double.maxFinite,
                color: Colors.blueGrey,
              ),


              //footer
              Container(
                height: 500,
                width: double.maxFinite,
              ),
            ],
          ),


        );
      }
    );
  }
}
