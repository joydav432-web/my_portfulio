import 'package:flutter/material.dart';
import 'widgets/stack_card.dart';

class TechnicalStackSection extends StatelessWidget {
  const TechnicalStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final horizontalPadding = (width * 0.05).clamp(20.0, 60.0);

        final verticalPadding = (width * 0.05).clamp(35.0, 60.0);

        final titleFont = (width * 0.012).clamp(11.0, 13.0);

        final sectionGap = (width * 0.05).clamp(30.0, 55.0);

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "TECHNICAL STACK",
                    style: TextStyle(
                      color: const Color(0xffAA2E1B),
                      fontSize: titleFont,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),

                  SizedBox(width: (width * 0.03).clamp(12.0, 24.0)),

                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),

              SizedBox(height: sectionGap),
              width <= 600
                  /// MOBILE
                  ? Column(
                      children: [
                        /// CARDS HERE
                        StackCard(
                          icon: Icons.phone_android_rounded,
                          title: "MOBILE DEVELOPMENT",
                          skills: const [
                            "Flutter",
                            "Dart",
                            "Firebase",
                            "REST API",
                            "Provider",
                            "GetX",
                          ],
                        ),

                        SizedBox(height: sectionGap),

                        StackCard(
                          icon: Icons.web_rounded,
                          title: "BACKEND & DATABASE",
                          skills: const [
                            "Firebase",
                            "Firestore",
                            "Authentication",
                            "SQLite",
                            "Shared Preferences",
                          ],
                        ),

                        SizedBox(height: sectionGap),

                        StackCard(
                          icon: Icons.design_services_rounded,
                          title: "UI / UX",
                          skills: const [
                            "Responsive UI",
                            "Material Design",
                            "Animation",
                            "Figma",
                          ],
                        ),

                        SizedBox(height: sectionGap),

                        StackCard(
                          icon: Icons.build_circle_outlined,
                          title: "TOOLS",
                          skills: const [
                            "Git",
                            "GitHub",
                            "Postman",
                            "Android Studio",
                            "VS Code",
                          ],
                        ),
                      ],
                    )
                  /// DESKTOP
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: const StackCard(
                      icon: Icons.phone_android_rounded,
                      title: "MOBILE DEVELOPMENT",
                      skills: [
                        "Flutter",
                        "Dart",
                        "Firebase",
                        "REST API",
                        "Provider",
                        "GetX",
                      ],
                    ),
                  ),

                  SizedBox(width: (width * .025).clamp(16.0, 35.0)),

                  Expanded(
                    child: const StackCard(
                      icon: Icons.web_rounded,
                      title: "BACKEND & DATABASE",
                      skills: [
                        "Firebase",
                        "Firestore",
                        "Authentication",
                        "SQLite",
                        "Shared Preferences",
                      ],
                    ),
                  ),

                  SizedBox(width: (width * .025).clamp(16.0, 35.0)),

                  Expanded(
                    child: const StackCard(
                      icon: Icons.design_services_rounded,
                      title: "UI / UX",
                      skills: [
                        "Responsive UI",
                        "Material Design",
                        "Animation",
                        "Figma",
                      ],
                    ),
                  ),

                  SizedBox(width: (width * .025).clamp(16.0, 35.0)),

                  Expanded(
                    child: const StackCard(
                      icon: Icons.build_circle_outlined,
                      title: "TOOLS",
                      skills: [
                        "Git",
                        "GitHub",
                        "Postman",
                        "Android Studio",
                        "VS Code",
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
