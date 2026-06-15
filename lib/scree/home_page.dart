import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_portfulio/constants/colors.dart';
import 'package:my_portfulio/widgets/customtext_formfield.dart';
import 'package:my_portfulio/widgets/drawer_mobile.dart';
import 'package:my_portfulio/widgets/header_mobile.dart';
import 'package:my_portfulio/widgets/partial_data.dart';
import 'package:my_portfulio/widgets/skills_mobile.dart';
import 'package:my_portfulio/widgets/theme_home.dart' hide PulseRing;

import '../widgets/header_desktop.dart';
import '../widgets/skill_desktop.dart';
import '../widgets/work_project.dart';

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
                width: screenWidth,
                padding: EdgeInsets.fromLTRB(25,20, 25, 60),
                color: CustomColor.bgLight1,
                
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("What I Can Do",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.whitePrimary
                    ),
                    ),

                    SizedBox(height: 50,),


                   if(Constraints.maxWidth>=600)
                     SkillDesktop()
                    else
                      SkillsMobile(),



              SizedBox(height: 20,),

              //project
                    Container(
                      width: screenWidth,
                      padding: EdgeInsets.fromLTRB(25, 20, 25, 60),
                      color: CustomColor.bgLight1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Text("Work Project",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: CustomColor.whitePrimary,
                            ),
                          ),

                          SizedBox(height: 20),

                          WorkProject(),

                        ],
                      ),
                    ),


              Container(
                padding: EdgeInsets.fromLTRB(25, 20, 25, 60),
                color: CustomColor.bgLight1,
                child: Column(
                  children: [
                    Text("Get in Touch",style: TextStyle(

                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CustomColor.whitePrimary
                    ),),


                    SizedBox(height: 50),
                    
                    Row(
                      children: [
                        Flexible(
                          child: CustomTextFiled(
                            hintText: 'Your name',

                          )
                        ),

                        SizedBox(width: 15,),

                        Flexible(child: CustomTextFiled(
                          hintText: 'Email',
                        ))
                      ],
                    ),

                    SizedBox(height: 15,),

                    CustomTextFiled(
                      hintText: "Your message",
                      maxline: 10,
                    ),

                    SizedBox(height: 30,),

                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),

                            )
                          ),
                          child: Text("Get on Touch")),
                    )


                  ],
                ),

              ),

              //footer
              Container(
                height: 500,
                width: double.maxFinite,
              ),
            ],
          ),

        ),
        ]
        )


        );
      }
    );
  }
}

