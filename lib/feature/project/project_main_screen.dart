import 'package:flutter/material.dart';
import 'package:my_portfulio/feature/project/widget/project_header.dart';
import 'package:my_portfulio/feature/project/widget/project_section.dart';

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
            ProjectHeader(),
            SizedBox(height: 60),

            ProjectSection(number: '01',
                child: Text(""))




          ],
        ),
      ),
    );
  }
}