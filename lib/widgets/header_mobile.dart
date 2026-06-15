import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/side_logo.dart';

import '../style/style.dart';

class HeaderMobile extends StatelessWidget {
  final VoidCallback? onLogoTap;
  final VoidCallback? onMenuTap;

  const HeaderMobile({
    super.key,
    this.onLogoTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(20, 5, 10, 5),
      decoration: khHeaderDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SideLogo(
              onTap: onLogoTap,
            ),
          ),

          IconButton(
            onPressed: onMenuTap,
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}