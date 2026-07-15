import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/hireme_button.dart';
import 'package:my_portfulio/widgets/responsive.dart';
import 'package:my_portfulio/widgets/side_logo.dart';

import '../../constants/nav_item.dart';
import '../../widgets/header_circularavatar.dart';

class HeaderDesktop extends StatefulWidget {
  const HeaderDesktop({
    super.key,
    required this.onMenuTap,
    required this.selectedIndex,
  });

  final Function(int) onMenuTap;
  final int selectedIndex;

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

    final RenderBox parent =
    navBarKey.currentContext!.findRenderObject() as RenderBox;

    final RenderBox child =
    itemKeys[widget.selectedIndex].currentContext!.findRenderObject()
    as RenderBox;

    final Offset offset =
    child.localToGlobal(Offset.zero, ancestor: parent);

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

          final navFontSize = responsiveSize(
            width,
            min: 11,
            max: 14,
            minWidth: 600,
            maxWidth: 1100,
          );

          final navGap = responsiveSize(
            width,
            min: 8,
            max: 16,
            minWidth: 600,
            maxWidth: 1100,
          );

          return Container(
              height: 60,
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Row(
                  children: [
                  SideLogo(onTap: () {}),

          // ========= CENTER NAV =========

          Expanded(
          child: Center(
          child: Stack(
          key: navBarKey,
          clipBehavior: Clip.none,
          children: [                      // Navigation Items
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < navTiles.length; i++)
                  Padding(
                    padding: EdgeInsets.only(right: navGap),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) =>
                          setState(() => hoveredIndex = i),
                      onExit: (_) =>
                          setState(() => hoveredIndex = -1),
                      child: GestureDetector(
                        onTap: () => widget.onMenuTap(i),
                        child: Container(
                          key: itemKeys[i],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: AnimatedDefaultTextStyle(
                            duration:
                            const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                            style: TextStyle(
                              fontSize: navFontSize,
                              fontWeight:
                              widget.selectedIndex == i
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: widget.selectedIndex == i
                                  ? Colors.white
                                  : hoveredIndex == i
                                  ? Colors.white
                                  : Colors.white70,
                            ),
                            child: AnimatedScale(
                              duration:
                              const Duration(milliseconds: 200),
                              scale: hoveredIndex == i ? 1.08 : 1,
                              child: Text(navTiles[i]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Sliding Underline
            Positioned(
              bottom: -2,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOutCubic,
                margin: EdgeInsets.only(left: indicatorLeft),
                width: indicatorWidth,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFFF62440),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF62440)
                          .withOpacity(.45),
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


                    Row(
                      children: [
                        HoverCircleAvatar(
                          image: "assets/images/github.png",
                        ),

                        const SizedBox(width: 15),

                        HoverCircleAvatar(
                          image: "assets/images/linkedin.png",
                        ),

                        const SizedBox(width: 15),

                        const Text(
                          "|",
                          style: TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(width: 15),

                        HireMeButton(
                          onPressed: () {},
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