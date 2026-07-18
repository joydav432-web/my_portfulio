import 'package:flutter/material.dart';

class ProjectHeader extends StatelessWidget {
  const ProjectHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final horizontalPadding = (width * 0.05).clamp(20.0, 20.0);
        final titleFont = (width * 0.06).clamp(36.0, 78.0);
        final smallFont = (width * 0.011).clamp(10.0, 13.0);

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: (width * 0.05).clamp(30.0, 55.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Top Text + Line
              Row(
                children: [

                  Text(
                    "SELECTED WORK",
                    style: TextStyle(
                      color: const Color(0xffAA2E1B),
                      fontSize: smallFont,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),

                  SizedBox(width: (width * .02).clamp(10.0, 20.0)),

                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),

              SizedBox(height: (width * .03).clamp(18.0, 35.0)),

              /// Desktop
              if (width > 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Expanded(
                      child: Text(
                        "Projects",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: titleFont,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "ALL PROJECTS",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: smallFont,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                )

              /// Mobile
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Projects",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: titleFont,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                    ),

                    SizedBox(height: (width * .05).clamp(18.0, 25.0)),

                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Text(
                            "ALL PROJECTS",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: smallFont,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              SizedBox(height: (width * .04).clamp(25.0, 40.0)),

              /// Bottom Border
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade800,
              ),
            ],
          ),
        );
      },
    );
  }
}