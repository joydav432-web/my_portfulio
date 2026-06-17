import 'package:flutter/material.dart';
import 'package:my_portfulio/style/style.dart';
import 'package:my_portfulio/widgets/responsive.dart';
import 'package:my_portfulio/widgets/side_logo.dart';

import '../constants/colors.dart';
import '../constants/nav_item.dart';

class HeaderDesktop extends StatefulWidget {
  const HeaderDesktop({
    super.key,
    required this.onMenuTap});

  final Function(int)onMenuTap;

  @override
  State<HeaderDesktop> createState() => _HeaderDesktopState();
}

class _HeaderDesktopState extends State<HeaderDesktop> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final navFontSize = responsiveSize(
          width,
          min: 13,
          max: 16,
          minWidth: 600,
          maxWidth: 1100,
        );
        final navGap = responsiveSize(
          width,
          min: 6,
          max: 14,
          minWidth: 600,
          maxWidth: 1100,
        );

        return Container(
          height: 60,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 10.00, vertical: 20.00),
          decoration: khHeaderDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SideLogo(
                onTap: () {},
              ),

              const Spacer(),

              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < navTiles.length; i++)
                        Padding(
                          padding: EdgeInsets.only(right: navGap),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              widget.onMenuTap(i);
                            },
                            child: Text(
                              navTiles[i],
                              style: TextStyle(
                                fontSize: navFontSize,
                                fontWeight: FontWeight.w500,
                                color: CustomColor.whitePrimary,
                              ),
                            ),
                          ),
                        )
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