
import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/projectdesktop.dart';

class WorkProject extends StatelessWidget {
  const WorkProject({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      ProjectData(
        number: "Project 1",
        title: "TRUCKLAC",
        description:
        "Streamline your transport business with our Truck Management App.",
        techStack: [
          'Dart',
          'Flutter',
          'REST API',
          'Firebase',
          'Responsive UI'
        ],
        imagePaths: ['assets/images/project_1.jpeg'],
        githubUrl: 'https://github.com/joydav432-web/Card-view',
      ),
      ProjectData(
        number: "Project 2",
        title: "TRUCKLACK",
        description:
        "Management your daily earn and expenses with our expenses Trucker",
        techStack: [
          'Dart',
          'Flutter',
          'SharedPreference',
          'Firebase',
          'Responsive UI'
        ],
        imagePaths: ['assets/images/app_2.jpeg'],
        githubUrl: 'https://github.com/joydav432-web/expense_trucker',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= 600;
        final cols = isMobile
            ? 1
            : constraints.maxWidth <= 900
            ? 2
            : 3;

        const spacing = 12.0;

        final cardWidth =
            (constraints.maxWidth - spacing * (cols - 1)) / cols;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.center,
          children: projects.map((p) {
            return SizedBox(
              width: cardWidth,
              child: ProjectCard(project: p),
            );
          }).toList(),
        );
      },
    );
  }
}