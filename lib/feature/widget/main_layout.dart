import 'package:flutter/material.dart';

import '../home/desktop/header_desktop.dart';
import '../home/mobile/header_mobile.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const MainLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
  });

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;

      case 1:
        Navigator.pushReplacementNamed(context, '/about');
        break;

      case 2:
        Navigator.pushReplacementNamed(context, '/projects');
        break;

      case 3:
        Navigator.pushReplacementNamed(context, '/contact');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 600;

          return Column(
            children: [

              const SizedBox(height: 25),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 35 : 20,
                ),
                child: isDesktop
                    ? HeaderDesktop(
                  selectedIndex: selectedIndex,
                  onMenuTap: (index) => _navigate(context, index),
                )
                    : NewHeaderMobile(
                  onMenuTap: () {
                    // Drawer open
                  },
                ),
              ),

              Expanded(
                child: child,
              ),
            ],
          );
        },
      ),
    );
  }
}