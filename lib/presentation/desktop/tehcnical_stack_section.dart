import 'package:flutter/material.dart';

import '../desktop_widgets/stack_card.dart';

class TechnicalStackSection extends StatelessWidget {
  const TechnicalStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 45,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Top Title
          Row(
            children: [

              Text(
                "TECHNICAL STACK",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 10,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey.withOpacity(.2),
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth <= 600;

              if (isMobile) {
                return Column(
                  children: const [
                    StackCard(
                      icon: Icons.phone_android_outlined,
                      title: "FLUTTER & MOBILE",
                      skills: [
                        "Flutter",
                        "Dart",
                        "Material 3",
                        "Responsive UI",
                        "Cupertino",
                      ],
                    ),

                    SizedBox(height: 30),

                    StackCard(
                      icon: Icons.account_tree_outlined,
                      title: "STATE MANAGEMENT",
                      skills: [
                        "Provider",
                        "Riverpod",
                        "GetX",
                      ],
                    ),

                    SizedBox(height: 30),

                    StackCard(
                      icon: Icons.cloud_outlined,
                      title: "BACKEND & APIs",
                      skills: [
                        "REST API",
                        "Firebase",
                        "HTTP",
                        "JWT",
                        "Cloud Firestore",
                      ],
                    ),

                    SizedBox(height: 30),

                    StackCard(
                      icon: Icons.settings_outlined,
                      title: "TOOLS & DEPLOYMENT",
                      skills: [
                        "Android Studio",
                        "Postman",
                        "Google Play Console",
                        "GitHub",
                        "OpenAI",
                      ],
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: StackCard(
                      icon: Icons.phone_android_outlined,
                      title: "FLUTTER & MOBILE",
                      skills: [
                        "Flutter",
                        "Dart",
                        "Material 3",
                        "Responsive UI",
                        "Cupertino",
                      ],
                    ),
                  ),

                  SizedBox(width: 60),

                  Expanded(
                    child: StackCard(
                      icon: Icons.account_tree_outlined,
                      title: "STATE MANAGEMENT",
                      skills: [
                        "Provider",
                        "Riverpod",
                        "GetX",
                      ],
                    ),
                  ),

                  SizedBox(width: 60),

                  Expanded(
                    child: StackCard(
                      icon: Icons.cloud_outlined,
                      title: "BACKEND & APIs",
                      skills: [
                        "REST API",
                        "Firebase",
                        "HTTP",
                        "JWT",
                        "Cloud Firestore",
                      ],
                    ),
                  ),

                  SizedBox(width: 60),

                  Expanded(
                    child: StackCard(
                      icon: Icons.settings_outlined,
                      title: "TOOLS & DEPLOYMENT",
                      skills: [
                        "Android Studio",
                        "Postman",
                        "Google Play Console",
                        "GitHub",
                        "OpenAI",
                      ],
                    ),
                  ),
                ],
              );
            },
          )        ],
      ),
    );
  }
}

