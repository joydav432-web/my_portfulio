import 'package:flutter/material.dart';
import 'package:my_portfulio/feature/home/desktop/new_desktopHome.dart';
import 'package:my_portfulio/feature/home/desktop/tehcnical_stack_section.dart';
import 'package:my_portfulio/feature/home/mobile/mobile_home.dart';

import '../feature/project/widget/project_card_section.dart';

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
        final isDesktop = constraints.maxWidth > 600;

        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        children: [
                          isDesktop ? const DesktopHome() : const MobileHero(),

                          const TechnicalStackSection(),

                          const SizedBox(height: 20),

                          ProjectCardSection(isDesktop: isDesktop),
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
