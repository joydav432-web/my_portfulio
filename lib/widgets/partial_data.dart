import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/puls_ring.dart';

class PartialData extends StatefulWidget {
  const PartialData({super.key});

  @override
  State<PartialData> createState() => _PartialDataState();
}

class _PartialDataState extends State<PartialData> {


  late final screenSize = MediaQuery.of(context).size;
  late final screenWidth = screenSize.width;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final w = constraints.maxWidth;
        final imageSize = w * 0.50;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          height: isMobile ? null : screenSize.height / 1.2,
          constraints: BoxConstraints(minHeight: 350.0),
          child: isMobile
              ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    PulseRing(
                      size: imageSize + 30,
                      color: CustomColor.yellowSecondary.withOpacity(0.12),
                    ),
                    Container(
                      width: imageSize,
                      height: imageSize * 1.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: CustomColor.yellowSecondary.withOpacity(0.35),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.yellowSecondary.withOpacity(0.12),
                            blurRadius: 30,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/my_2.jpg', fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25),

                // তারপর text
                Text(
                  "Hii,\nI'm JOY DEB\nA Flutter Developer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: w < 400 ? 22 : 26,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.whitePrimary,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColor.yellowSecondary,
                    ),
                    child: Text("Get in Touch",
                      style: TextStyle(color: CustomColor.whitePrimary),
                    ),
                  ),
                ),
              ],
            ),
          )
              : Row( // Desktop layout
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hii,\nI'm JOY DEB\nA Flutter Developer",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: CustomColor.whitePrimary,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.yellowSecondary,
                      ),
                      child: Text("Get in Touch",
                        style: TextStyle(color: CustomColor.whitePrimary),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  PulseRing(
                    size: screenWidth / 3 + 40,
                    color: CustomColor.yellowSecondary.withOpacity(0.15),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: CustomColor.yellowSecondary.withOpacity(0.35),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.yellowSecondary.withOpacity(0.12),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/my_2.jpg',
                        width: screenWidth / 3,
                        fit: BoxFit.cover,
                      ),
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
