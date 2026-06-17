import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/responsive.dart';
import 'package:my_portfulio/widgets/resume_button.dart';

import '../constants/colors.dart';
import '../constants/puls_ring.dart';

class PartialData extends StatefulWidget {
  const PartialData({super.key});

  @override
  State<PartialData> createState() => _PartialDataState();
}

class _PartialDataState extends State<PartialData> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
        final screenWidth = constraints.maxWidth;

        final isDesktop = isDesktopWidth(screenWidth);


        final imageSize = isDesktop
            ? responsiveSize(screenWidth, min: 170, max: 320, minWidth: 600, maxWidth: 1400)
            : responsiveSize(screenWidth, min: 140, max: 220, minWidth: 320, maxWidth: 600);

        final titleFontSize = isDesktop
            ? responsiveSize(screenWidth, min: 24, max: 38, minWidth: 600, maxWidth: 1400)
            : responsiveSize(screenWidth, min: 20, max: 28, minWidth: 320, maxWidth: 600);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: isDesktop ? screenSize.height / 1.2 : null,
          constraints: const BoxConstraints(minHeight: 350),
          child: isDesktop
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hii,\nI'm JOY DEB\nA Flutter Developer",
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w500,
                        color: CustomColor.whitePrimary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: ()=>openResume(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffF62440),
                        ),
                        child: Text(
                          "Resume",
                          style: TextStyle(
                            color: CustomColor.whitePrimary,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                flex: 2,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PulseRing(
                        size: imageSize + 40,
                        color: CustomColor.yellowSecondary.withOpacity(0.15),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/my_2.jpg',
                          width: imageSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )

              : Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 20,
            ),
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
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/my_2.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Text(
                  "Hii,\nI'm JOY DEB\nA Flutter Developer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.whitePrimary,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF62440),
                    ),
                    child: Text(
                      "Resume",
                      style: TextStyle(
                        color: CustomColor.whiteSecondary,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}