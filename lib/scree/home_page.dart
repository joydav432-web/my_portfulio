import 'package:flutter/material.dart';
import 'package:my_portfulio/feature/home/desktop/new_desktopHome.dart';
import 'package:my_portfulio/feature/home/desktop/tehcnical_stack_section.dart';
import 'package:my_portfulio/feature/home/mobile/mobile_home.dart';
import 'package:my_portfulio/feature/project/widget/project_header.dart';

import '../feature/home/desktop/header_desktop.dart';
import '../feature/home/mobile/header_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    final screenWidth = screenSize.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          child: Scaffold(


            body: Column(
              children: [

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Column(
                        children: [

                          if (constraints.maxWidth >= 600)
                            Container(
                              child: DesktopHome(),
                            )

                          else
                            Container(
                              child: MobileHero(),
                            )                      ,


                          // SKILLS SECTION
                          Container(
                            child: const TechnicalStackSection(),
                          ),
                          const SizedBox(height: 20),

                          // PROJECT SECTION
                          Container(
                            child: const ProjectHeader(),
                          ),
                          const SizedBox(height: 10),

                          // CONTACT SECTION


                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}