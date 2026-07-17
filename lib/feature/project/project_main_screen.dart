import 'package:flutter/material.dart';

import '../widget/main_layout.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      selectedIndex: 2,
      child:
        Center(
        child: Text("Projects Page"),
      ),
    );
  }
}