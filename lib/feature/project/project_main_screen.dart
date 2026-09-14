import 'package:flutter/material.dart';
import 'package:my_portfulio/feature/project/widget/project_card_section.dart';
import 'package:my_portfulio/widgets/scroll_reveal.dart';
import '../fotter/desktop_fotter.dart';
import '../fotter/mobile_fotter.dart';
import '../widget/main_layout.dart';
class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 2,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 600;

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),

                ProjectCardSection(isDesktop: isDesktop),

                const SizedBox(height: 60),

                ScrollReveal(
                  delay: const Duration(milliseconds: 100),
                  child: isDesktop ? const DesktopFooter() : const MobileFooter(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}