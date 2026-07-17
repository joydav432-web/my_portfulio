import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/side_logo.dart';

class NewHeaderMobile extends StatelessWidget {
  const NewHeaderMobile({
    super.key,
    required this.onMenuTap,
  });

  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Responsive Values
        final horizontalPadding = width * .04;
        final headerHeight = (width * .16).clamp(56.0, 70.0);
        final iconBox = (width * .12).clamp(42.0, 50.0);
        final iconSize = (width * .07).clamp(22.0, 30.0);

        return Container(
          height: headerHeight,
          margin: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 12,
          ),
          child: Row(
            children: [
              /// Logo
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: SideLogo(
                      onTap: () {},
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// Menu Button
              Material(
                color: const Color(0xff1B1B1B),
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onMenuTap,
                  child: Container(
                    width: iconBox,
                    height: iconBox,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.menu_rounded,
                      color: Colors.white,
                      size: iconSize,
                    ),
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