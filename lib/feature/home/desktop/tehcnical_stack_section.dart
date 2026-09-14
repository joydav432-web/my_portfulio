import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/scroll_reveal.dart';

import 'widgets/stack_card.dart';

class TechnicalStackSection extends StatelessWidget {
  const TechnicalStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final horizontalPadding = (width * 0.05).clamp(20.0, 20.0);
        final verticalPadding = (width * 0.05).clamp(35.0, 60.0);
        final titleFont = (width * 0.012).clamp(11.0, 13.0);
        final sectionGap = (width * 0.05).clamp(30.0, 55.0);

        final cardData = [
          _CardData(
            icon: Icons.phone_android_rounded,
            title: "MOBILE DEVELOPMENT",
            skills: ["Flutter", "Dart", "Firebase", "REST API", "Provider", "GetX"],
          ),
          _CardData(
            icon: Icons.web_rounded,
            title: "BACKEND & DATABASE",
            skills: [
              "Firebase",
              "Firestore",
              "Authentication",
              "SQLite",
              "Shared Preferences"
            ],
          ),
          _CardData(
            icon: Icons.design_services_rounded,
            title: "UI / UX",
            skills: ["Responsive UI", "Material Design", "Animation", "Figma"],
          ),
          _CardData(
            icon: Icons.build_circle_outlined,
            title: "TOOLS",
            skills: ["Git", "GitHub", "Postman", "Android Studio", "VS Code"],
          ),
        ];

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header with reveal
              ScrollReveal(
                delay: const Duration(milliseconds: 0),
                child: Row(
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
                      child: Container(height: 1, color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ),

              SizedBox(height: sectionGap),

              // Cards
              width <= 600
                  // MOBILE — stacked
                  ? Column(
                      children: List.generate(cardData.length, (i) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: i < cardData.length - 1 ? sectionGap : 0),
                          child: ScrollReveal(
                            delay: Duration(milliseconds: 80 * i),
                            slideOffset: 30,
                            child: StackCard(
                              icon: cardData[i].icon,
                              title: cardData[i].title,
                              skills: cardData[i].skills,
                            ),
                          ),
                        );
                      }),
                    )
                  // DESKTOP — row
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(cardData.length, (i) {
                        return Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: ScrollReveal(
                                  delay: Duration(milliseconds: 100 * i),
                                  slideOffset: 30,
                                  child: StackCard(
                                    icon: cardData[i].icon,
                                    title: cardData[i].title,
                                    skills: cardData[i].skills,
                                  ),
                                ),
                              ),
                              if (i < cardData.length - 1)
                                SizedBox(
                                    width: (width * .025).clamp(16.0, 35.0)),
                            ],
                          ),
                        );
                      }),
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _CardData {
  final IconData icon;
  final String title;
  final List<String> skills;
  const _CardData(
      {required this.icon, required this.title, required this.skills});
}
