import 'package:flutter/material.dart';
import 'package:my_portfulio/feature/project/widget/project_card_section.dart';
import '../widget/main_layout.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 2,

      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),

            ProjectCardSection(isDesktop: true),
          ],
        ),
      ),
    );
  }
}
