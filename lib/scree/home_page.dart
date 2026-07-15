import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_portfulio/constants/colors.dart';
import 'package:my_portfulio/widgets/contact_section.dart';
import 'package:my_portfulio/widgets/drawer_mobile.dart';
import 'package:my_portfulio/widgets/header_mobile.dart';
import 'package:my_portfulio/widgets/skills_mobile.dart';
import 'package:my_portfulio/widgets/section_header.dart';
import 'package:my_portfulio/presentation/desktop/tehcnical_stack_section.dart';

import '../presentation/desktop/desktop_home.dart';
import '../presentation/desktop/header_desktop.dart';
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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            endDrawer: constraints.maxWidth >= 600
                ? null
                : DrawerMobile(
              onNavItemTap: (int navIndex) {
                scrollToSection(navIndex);
                scaffoldKey.currentState?.closeEndDrawer();
              },
            ),
            body: Column(
              children: [
                // Fixed Header
                if (constraints.maxWidth >= 600)
                  Padding(
                    padding: const EdgeInsets.only(left: 35, right: 35),
                    child: HeaderDesktop(
                      selectedIndex: selectedIndex,
                      onMenuTap: (int navIndex) {
                        scrollToSection(navIndex);
                      },
                    ),
                  )
                else
                  HeaderMobile(
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                    onLogoTap: () {},
                  ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        SizedBox(key: navbarKeys[0]),
                        const HeroSection(),

                        // SKILLS SECTION
                       TechnicalStackSection(),
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
                              const SectionHeader(title: "Work Projects"),
                              const SizedBox(height: 20),
                              const WorkProject(),
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
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: CustomColor.whiteSecondary,
                            ),
                          ),
                        ),
                      ],
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

  void scrollToSection(int navIndex) {
    if (navIndex < 0 || navIndex >= navbarKeys.length) return;

    setState(() {
      selectedIndex = navIndex;
    });

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