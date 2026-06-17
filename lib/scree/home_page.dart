import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_portfulio/constants/colors.dart';
import 'package:my_portfulio/widgets/contact_section.dart';
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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,

          backgroundColor: const Color(0xFF0D0D1A),

          endDrawer: constraints.maxWidth >= 600
              ? null
              : DrawerMobile(
            onNavItemTap: (int navIndex) {
              scrollToSection(navIndex);
              scaffoldKey.currentState?.closeEndDrawer();
            },
          ),


          body: ParticleBackground(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: scrollController,
              child: Column(
                children: [
                  SizedBox(key: navbarKeys[0]),

                  if (constraints.maxWidth >= 600)
                    HeaderDesktop(
                      onMenuTap: (int navIndex) {
                        scrollToSection(navIndex);
                      },
                    )
                  else
                    HeaderMobile(
                      onMenuTap: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                      onLogoTap: () {},
                    ),

                  const PartialData(),

                  // SKILLS SECTION
                  Container(
                    key: navbarKeys[1],
                    width: screenWidth,
                    padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),

                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "What I Can Do",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.whitePrimary,
                          ),
                        ),
                        const SizedBox(height: 50),
                        if (constraints.maxWidth >= 600)
                          SkillDesktop()
                        else
                          SkillsMobile(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // PROJECT SECTION
                  Container(
                    key: navbarKeys[2],
                    width: screenWidth,
                    padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
                    color: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Work Project",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: CustomColor.whitePrimary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        WorkProject(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // CONTACT SECTION
                  ContactSection(
                    key: navbarKeys[3],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      "Made by JOYDEB with flutter 3.44.1",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.whiteSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void scrollToSection(int navIndex) {
    if (navIndex < 0 || navIndex >= navbarKeys.length) return;

    final key = navbarKeys[navIndex];
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      alignment: 0.1,
    );
  }
}