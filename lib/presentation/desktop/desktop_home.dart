import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 60,
      ),
      decoration: const BoxDecoration(
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          /// LEFT SIDE
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Top Info
                Row(
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

                    const Text(
                      "Available for work",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(width: 25),

                    Container(
                      width: 1,
                      height: 15,
                      color: Colors.white12,
                    ),

                    const SizedBox(width: 25),

                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white54,
                      size: 15,
                    ),

                    const SizedBox(width: 5),

                    const Text(
                      "Dhaka, Bangladesh",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                /// Heading

                const Text(
                  "Crossplatform-Quality UI",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),

                RichText(
                  text: const TextSpan(
                    children: [

                      TextSpan(
                        text: "Flutter",
                        style: TextStyle(
                          color: Color(0xffF44336),
                          fontSize: 72,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),

                      TextSpan(
                        text: "Developer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: 650,
                  child: Text("Flutter Developer with a passion for crafting elegant and responsive mobile applications"
                      "Experienced in Flutter, Firebase, API integration, and clean UI/UX implementation."
                      "Committed to building scalable, maintainable, and high-quality software.",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 18,
                      height: 1.7,
                    ),
                  ),
                ),

                const SizedBox(height: 45),

                /// Buttons

                Row(
                  children: [

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF44336),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(170, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text(
                        "RESUME",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.white.withOpacity(.2),
                        ),
                        minimumSize: const Size(170, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Text(
                            "VIEW WORK",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 8),

                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 60),

          /// RIGHT IMAGE

          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.grey.shade900,
                  image: const DecorationImage(
                    image: AssetImage("assets/images/my_3.png"),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(.05),
                      blurRadius: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}