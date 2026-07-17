import 'package:flutter/material.dart';

class MobileHero extends StatelessWidget {
  const MobileHero();

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final imageSize = width * .55;
        final titleSize = width * .075;
        final nameSize = width * .11;
        final bodySize = width * .040;
        final buttonHeight = width * .14;

        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: imageSize.clamp(170.0, 260.0),
                height: imageSize.clamp(170.0, 260.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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

              const SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Text(
                    "Available for work",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: (width * 0.038).clamp(11.0, 15.0),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white54,
                    size: 15,
                  ),
                  SizedBox(width: 5),

                  Text(
                    "Dhaka Bangladesh",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: (width * 0.038).clamp(11.0, 15.0),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

               Text(
                "Crossplatform-Quality UI",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: titleSize.clamp(24.0, 34.0),
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              RichText(
                textAlign: TextAlign.center,
                text:  TextSpan(
                  children: [
                    TextSpan(
                      text: "Flutter\n",
                      style: TextStyle(
                        color: Color(0xffF44336),
                        fontSize: titleSize.clamp(24.0, 34.0),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: "Developer",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: titleSize.clamp(24.0, 34.0),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .04),
                child: Text(
                  textAlign: TextAlign.center,
                  "Flutter Developer with a passion for crafting elegant and responsive mobile applications.\nExperienced in Flutter, Firebase, REST API integration and clean UI implementation.\nCommitted to building scalable and high-quality software.",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: (width * 0.038).clamp(11.0, 15.0),
                    height: 1.8,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: buttonHeight.clamp(48.0, 58.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffF44336),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.download,
                    size: (width * 0.05).clamp(18.0, 24.0),
                  ),
                  label: Text(
                    "RESUME",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: (width * 0.04).clamp(13.0, 16.0),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: buttonHeight.clamp(48.0, 58.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.white.withOpacity(.2),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .04,
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
                          fontSize: (width * 0.04).clamp(13.0, 16.0),
                        ),
                      ),

                      SizedBox(width: width * 0.02),

                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: (width * 0.05).clamp(18.0, 22.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
