
import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/projectdesktop.dart';

class WorkProject extends StatelessWidget {
  const WorkProject({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [

      ProjectData(
        number: "Project 1",
        title: "Photopia",
        description:
        "Photopia is a smart photography service platform that connects clients "
            "with professional photographers for various events and occasions. "
            "It allows users to create an account, browse photographer profiles, "
            "and hire the right professional for weddings, birthdays, corporate "
            "events, and personal photoshoots. Individuals can also register as "
            "photographers, showcase their portfolios, and receive booking requests "
            "from potential clients. ",
        techStack: [
          'Dart',
          'Flutter',
          'REST API',
          'Firebase',
          'Responsive UI'
        ],
        imagePaths: ['assets/images/onbording_1.png',
          'assets/images/photopia_2.png',
          'assets/images/photopia_3.png',
          'assets/images/photopia_4.png',
          'assets/images/photopia_5.png'

        ],
        githubUrl: 'https://github.com/joydav432-web/photopia',
      ),

      ProjectData(
        number: "Project 2",
        title: "TRUCKLAC",
        description:
        "Trucklac is a business-focused vehicle finance management "
            "solution built for taxi, car, and transport operators. "
            "The application enables users to monitor fuel costs, maintenance expenses, "
            "daily earnings, and profitability through detailed tracking tools. "
            "It also offers secure account authentication, PDF report generation, "
            "and flexible history management features for efficient record keeping "
            "and operational analysis.",
        techStack: [
          'Dart',
          'Flutter',
          'REST API',
          'Firebase',
          'Responsive UI'
        ],
        imagePaths: ['assets/images/project_1.jpeg',
          'assets/images/trucklac_91.png',
          'assets/images/trucklac_92.png'

        ],
        githubUrl: 'https://github.com/joydav432-web/Card-view',
      ),
      ProjectData(
        number: "Project 3",
        title: "Expenses Trucker",
        description:
        "Expense Tracker App is a personal finance management application "
            "that helps users record and organize their daily income and expenses. "
            "It provides real-time calculations of total earnings, spending,"
            " and available balance to simplify budget planning. With a clean themed "
            "interface and persistent data storage, users can easily analyze their"
            " financial activities and maintain better control over their money."        ,
        techStack: [
          'Dart',
          'Flutter',
          'SharedPreference',
          'Firebase',
          'Responsive UI'
        ],
        imagePaths: ['assets/images/project_2.jpeg',
        'assets/images/trucker_1.png',

        ],
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