import 'package:flutter/material.dart';
import 'package:my_portfulio/feature/home/desktop/new_desktopHome.dart';
import 'package:my_portfulio/feature/home/desktop/tehcnical_stack_section.dart';
import 'package:my_portfulio/feature/home/mobile/mobile_home.dart';
import 'package:my_portfulio/feature/project/widget/desktop_project_card.dart';
import 'package:my_portfulio/feature/project/widget/desktop_section_number.dart';
import 'package:my_portfulio/feature/project/widget/mobile_section_number.dart';
import 'package:my_portfulio/feature/project/widget/project_header.dart';

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

                          const ProjectHeader(),

                          isDesktop
                              ? const DesktopSectionNumber(number: '01')
                              : const MobileSectionNumber(number: '01'),

                          ResponsiveProjectCard(
                            project: ProjectData(
                              category:
                                  'Flutter E-Commerce Application • REST API • Firebase Authentication',

                              title: 'CraftyBay – Modern E-Commerce Mobile App',

                              description:
                                  'A robust Express TypeScript backend system designed for a road-trip directory and mapping service.',
                              bulletPoints: [
                                'Implemented dynamic product listing, category browsing, and product details using REST API integration',

                                'Developed secure user authentication with email verification, login, registration, and profile management',

                                'Built wishlist, shopping cart, product reviews, and order management with responsive UI across Android devices',

                                'Integrated image sliders, search functionality, product variants, and real-time state management using Provider',
                              ],

                              techTags: [
                                'Flutter',
                                'Dart',
                                'REST API',
                                'Provider',
                                'Firebase',
                                'Shared Preferences',
                                'Clean Architecture',
                                'Material Design',
                              ],
                              imagePath: 'assets/images/crafty_bay_cover.png',
                            ),
                          ),
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
