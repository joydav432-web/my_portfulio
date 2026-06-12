import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_portfulio/constants/colors.dart';
import 'package:my_portfulio/widgets/drawer_mobile.dart';
import 'package:my_portfulio/widgets/header_mobile.dart';
import 'package:my_portfulio/widgets/partial_data.dart';
import 'package:my_portfulio/widgets/projectdesktop.dart';
import 'package:my_portfulio/widgets/skills_mobile.dart';
import 'package:my_portfulio/widgets/theme_home.dart' hide PulseRing;

import '../widgets/header_desktop.dart';
import '../widgets/skill_desktop.dart';

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
                    Text("What I Can DO",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: CustomColor.whitePrimary
                    ),
                    ),

                    SizedBox(height: 50,),


                   if(Constraints.maxWidth>=600)
                     SkillDesktop()
                    else
                      SkillsMobile(),



              SizedBox(height: 20,),

              //contact
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
                              fontWeight: FontWeight.w500,
                              color: CustomColor.whitePrimary,
                            ),
                          ),

                          SizedBox(height: 20),

                          // ✅ এই list-এ তোমার সব projects রাখো
                          Builder(builder: (_) {
                            final projects = [
                              ProjectData(
                                number: "Project 1",
                                title: "TRUCKLAC",
                                description: "Streamline your transport business with our Truck Management App."
                                    " Easily manage customers, truck owners, trip details, "
                                    "fuel expenses, costs, earnings, and profiles in one place."
                                    " Designed to simplify operations, improve efficiency, "
                                    "and keep your business organized.",
                                techStack: ['Dart', 'Flutter', 'REST API', 'Firebase', 'Responsive UI'],
                                imagePaths: ['assets/images/project_1.jpeg'],
                                githubUrl: 'https://github.com/joydav432-web/Card-view',
                              ),
                              ProjectData(
                                number: "Project 2",
                                title: "TRUCKLACK",
                                description: "Streamline your transport business with our Truck Management App."
                                    " Easily manage customers, truck owners, trip details, "
                                    "fuel expenses, costs, earnings, and profiles in one place."
                                    " Designed to simplify operations, improve efficiency, "
                                    "and keep your business organized.",
                                techStack: ['Dart', 'Flutter', 'REST API', 'Firebase', 'Responsive UI'],
                                imagePaths: ['assets/images/project_1.jpeg'],
                                githubUrl: 'https://github.com/joydav432-web/Card-view',
                              ),
                            ];

                            final isMobile = Constraints.maxWidth <= 600;
                            final cols     = isMobile ? 1 : Constraints.maxWidth <= 900 ? 2 : 3;
                            final spacing  = 12.0;

                            // card width = screen কে cols দিয়ে ভাগ করো, spacing বাদ দাও
                            final cardWidth = (Constraints.maxWidth - spacing * (cols - 1)) / cols;

                            return Wrap(
                              spacing: spacing,
                              runSpacing: spacing,
                              alignment: WrapAlignment.center, // ✅ মাঝখানে আনে
                              children: projects.map((p) => SizedBox(
                                width: cardWidth,
                                child: ProjectCard(project: p),
                              )).toList(),
                            );
                          }),

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
