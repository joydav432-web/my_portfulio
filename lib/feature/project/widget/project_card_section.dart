import 'package:flutter/material.dart';
import 'package:my_portfulio/feature/project/widget/project_header.dart';

import 'desktop_project_card.dart';
import 'desktop_section_number.dart';
import 'mobile_section_number.dart';

class ProjectCardSection extends StatelessWidget {
  const ProjectCardSection({
    super.key,
    required this.isDesktop,
  });

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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


        isDesktop
            ? const DesktopSectionNumber(number: '02')
            : const MobileSectionNumber(number: '02'),

        ResponsiveProjectCard(
          project: ProjectData(
            category:
            'Flutter Logistics Management • REST API • Provider • Firebase',

            title:
            'TruckLack – Smart Truck Business Management App',

            description:
            'A modern Flutter application built to simplify trucking business operations by managing driver bonuses, owner expenses, fuel costs, trip records, and financial calculations through a clean, responsive, and intuitive user experience.',

            bulletPoints: [
              'Developed an all-in-one trucking management solution for calculating driver bonuses, owner expenses, fuel costs, and operational reports.',

              'Integrated REST APIs for dynamic data synchronization, authentication, trip management, and financial calculations.',

              'Designed responsive dashboards with real-time business insights, history tracking, and advanced filtering for efficient workflow.',

              'Implemented secure authentication, Provider state management, reusable UI components, and scalable architecture for maintainability.',
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
            imagePath: 'assets/images/trucklack_cover.png',



          ),
        ),


        isDesktop
            ? const DesktopSectionNumber(number: '03')
            : const MobileSectionNumber(number: '03'),


        ResponsiveProjectCard(
          project: ProjectData(
            category:
            'Flutter Health & Nutrition App • UI/UX • Provider • Ongoing',

            title:
            'Ascela – Smart Health & Meal Planning App',

            description:
            'A modern Flutter application designed to help users manage healthy meal planning, nutrition tracking, and personalized wellness journeys through an elegant and intuitive user interface. The UI is nearly complete, while backend integration and core functionalities are currently under active development.',

            bulletPoints: [
              'Designed and developed a clean, modern, and responsive user interface with a strong focus on user experience and accessibility.',

              'Implemented reusable widgets, custom components, animations, and scalable UI architecture following Flutter best practices.',

              'Built multiple application flows including onboarding, meal planning, recipe browsing, favorites, and personalized nutrition screens.',

              'Currently integrating REST APIs, Provider state management, and backend services to enable dynamic data, authentication, and personalized user experiences.',
            ],

            techTags: [
              'Flutter',
              'Dart',
              'Provider',
              'REST API (In Progress)',
              'Firebase (Planned)',
              'Responsive UI',
              'Clean Architecture',
              'Material Design',
            ],
            imagePath: 'assets/images/acela_cover.png',



          ),
        ),
      ],
    );
  }
}
