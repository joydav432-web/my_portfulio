import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/hireme_button.dart';
import 'package:my_portfulio/widgets/responsive.dart';
import 'package:my_portfulio/widgets/side_logo.dart';

import '../../../widgets/header_circularavatar.dart';
import '../../../widgets/nav_item.dart';

class HeaderDesktop extends StatefulWidget {
  const HeaderDesktop({
    super.key,
    required this.selectedIndex,
    this.onMenuTap,
  });

  final int selectedIndex;
  final Function(int)? onMenuTap;

  @override
  State<HeaderDesktop> createState() => _HeaderDesktopState();
}

class _HeaderDesktopState extends State<HeaderDesktop>
    with TickerProviderStateMixin {

  int hoveredIndex = -1;

  final List<GlobalKey> itemKeys =
  List.generate(navTiles.length, (_) => GlobalKey());

  final GlobalKey navBarKey = GlobalKey();

  double indicatorLeft = 0;
  double indicatorWidth = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateIndicator();
    });
  }

  @override
  void didUpdateWidget(covariant HeaderDesktop oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedIndex != widget.selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        updateIndicator();
      });
    }
  }

  void updateIndicator() {
    if (navBarKey.currentContext == null) return;

    final parent =
    navBarKey.currentContext!.findRenderObject() as RenderBox;

    final child =
    itemKeys[widget.selectedIndex].currentContext!.findRenderObject()
    as RenderBox;

    final offset =
    child.localToGlobal(Offset.zero, ancestor: parent);

    if (!mounted) return;

    setState(() {
      indicatorLeft = offset.dx;
      indicatorWidth = child.size.width;
    });
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        final width = constraints.maxWidth;

        final horizontalMargin =
        responsiveSize(width,
            min: 12,
            max: 35,
            minWidth: 600,
            maxWidth: 1600);

        final navGap =
        responsiveSize(width,
            min: 6,
            max: 18,
            minWidth: 600,
            maxWidth: 1600);

        final navFontSize =
        responsiveSize(width,
            min: 11,
            max: 15,
            minWidth: 600,
            maxWidth: 1600);

        final iconGap =
        responsiveSize(width,
            min: 8,
            max: 15,
            minWidth: 600,
            maxWidth: 1600);

        return Container(
          height: 65,
          margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin,
            vertical: 20,
          ),
          child: Row(
            children: [

              /// Logo
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SideLogo(
                      onTap: () {},
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              /// Navigation
              Expanded(
                flex: 5,
                child: Center(
                  child: Stack(
                    key: navBarKey,
                    clipBehavior: Clip.none,
                    children: [

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < navTiles.length; i++)
                            Padding(
                              padding: EdgeInsets.only(
                                right: i == navTiles.length - 1 ? 0 : navGap,
                              ),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                onEnter: (_) => setState(() => hoveredIndex = i),
                                onExit: (_) => setState(() => hoveredIndex = -1),
                                child: GestureDetector(
                                  onTap: () {
                                    switch (i) {
                                      case 0:
                                        Navigator.pushReplacementNamed(context, '/');
                                        break;

                                      case 1:
                                      // About
                                        Navigator.pushReplacementNamed(context, '/about');
                                        break;

                                      case 2:
                                        Navigator.pushReplacementNamed(context, '/projects');
                                        break;

                                      case 3:
                                        Navigator.pushReplacementNamed(context, '/contact');
                                        break;
                                    }
                                  },
                                  child: Container(
                                    key: itemKeys[i],
                                    padding: EdgeInsets.symmetric(
                                      horizontal: responsiveSize(
                                        width,
                                        min: 8,
                                        max: 14,
                                        minWidth: 600,
                                        maxWidth: 1600,
                                      ),
                                      vertical: responsiveSize(
                                        width,
                                        min: 6,
                                        max: 10,
                                        minWidth: 600,
                                        maxWidth: 1600,
                                      ),
                                    ),
                                    child: AnimatedDefaultTextStyle(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeOut,
                                      style: TextStyle(
                                        fontSize: navFontSize,
                                        fontWeight: widget.selectedIndex == i
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        color: widget.selectedIndex == i
                                            ? Colors.white
                                            : hoveredIndex == i
                                            ? Colors.white
                                            : Colors.white70,
                                      ),
                                      child: AnimatedScale(
                                        duration: const Duration(milliseconds: 200),
                                        scale: hoveredIndex == i ? 1.08 : 1,
                                        child: Text(
                                          navTiles[i],
                                          overflow: TextOverflow.fade,
                                          softWrap: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      Positioned(
                        bottom: -2,
                        left: indicatorLeft,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOutCubic,
                          width: indicatorWidth,
                          height: 3,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF62440),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFF62440).withOpacity(.45),
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),

              const SizedBox(width: 15),

              /// Right Section
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          children: [
                            HoverCircleAvatar(
                              image: "assets/images/github.png",
                            ),

                            SizedBox(width: iconGap),

                            HoverCircleAvatar(
                              image: "assets/images/linkedin.png",
                            ),

                            SizedBox(width: iconGap),

                            Text(
                              "|",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: navFontSize + 2,
                              ),
                            ),

                            SizedBox(width: iconGap),

                            HireMeButton(
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}