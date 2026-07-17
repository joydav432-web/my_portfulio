import 'package:flutter/material.dart';

class DesktopHome extends StatelessWidget {
  const DesktopHome({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final topFont = (width * .010).clamp(12.0, 14.0);
        final titleFont = (width * .040).clamp(34.0, 52.0);
        final nameFont = (width * .060).clamp(48.0, 72.0);

        final bodyFont = (width * .015).clamp(15.0, 18.0);

        final imageSize = (width * .26).clamp(240.0, 340.0);

        final buttonWidth = (width * .14).clamp(150.0, 180.0);

        final gap = (width * .04).clamp(25.0, 60.0);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// LEFT
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TOP INFO
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: (width * .015).clamp(8.0, 20.0),
                    runSpacing: 10,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),

                      Text(
                        "Available for work",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: topFont,
                          letterSpacing: 1,
                        ),
                      ),

                      Container(width: 1, height: 14, color: Colors.white12),

                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white54,
                        size: topFont + 2,
                      ),

                      Text(
                        "Dhaka, Bangladesh",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: topFont,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: (width * .03).clamp(25.0, 40.0)),

                  Text(
                    "Crossplatform-Quality UI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFont,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Flutter ",
                          style: TextStyle(
                            color: const Color(0xffF44336),
                            fontSize: nameFont,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                        TextSpan(
                          text: "Developer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: nameFont,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: (width * .03).clamp(25.0, 35.0)),

                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: width * .60),
                    child: Text(
                      "Flutter Developer with a passion for crafting elegant and responsive mobile applications. "
                      "Experienced in Flutter, Firebase, API integration, and clean UI/UX implementation. "
                      "Committed to building scalable, maintainable, and high-quality software.",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: bodyFont,
                        height: 1.7,
                      ),
                    ),
                  ),

                  SizedBox(height: (width * .035).clamp(30.0, 45.0)),

                  Wrap(
                    spacing: (width * .015).clamp(12.0, 18.0),
                    runSpacing: 15,
                    children: [
                      SizedBox(
                        width: buttonWidth,
                        height: 60,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF44336),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.download,
                            size: (width * .016).clamp(18.0, 22.0),
                          ),
                          label: Text(
                            "RESUME",
                            style: TextStyle(
                              fontSize: (width * .012).clamp(13.0, 15.0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: buttonWidth,
                        height: 60,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.white.withOpacity(.20),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "VIEW WORK",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: (width * .012).clamp(13.0, 15.0),
                                ),
                              ),

                              SizedBox(width: (width * .006).clamp(6.0, 10.0)),

                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: (width * .016).clamp(18.0, 22.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: gap),

            /// RIGHT IMAGE
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerRight,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: imageSize,
                    maxHeight: imageSize,
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          (width * .015).clamp(18.0, 24.0),
                        ),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/my_3.png"),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(.05),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
