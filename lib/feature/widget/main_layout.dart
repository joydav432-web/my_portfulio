import 'package:flutter/material.dart';

import '../../widgets/cursor_glow.dart';
import '../../widgets/side_logo.dart';
import '../home/desktop/header_desktop.dart';
import '../home/mobile/header_mobile.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final int selectedIndex;

  const MainLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigate(BuildContext context, int index) {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _scaffoldKey.currentState?.closeDrawer();
    }

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
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: const Color(0xff111111),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SideLogo(
                  onTap: () => _navigate(context, 0),
                ),
                const SizedBox(height: 24),
                _buildDrawerItem(context, 'Home', 0),
                _buildDrawerItem(context, 'About', 1),
                _buildDrawerItem(context, 'Projects', 2),
                _buildDrawerItem(context, 'Contact', 3),
              ],
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 600;

          final content = Column(
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 35 : 20,
                ),
                child: isDesktop
                    ? HeaderDesktop(
                        selectedIndex: widget.selectedIndex,
                        onMenuTap: (index) => _navigate(context, index),
                      )
                    : NewHeaderMobile(
                        onMenuTap: () {
                          if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
                            _scaffoldKey.currentState?.closeDrawer();
                          } else {
                            _scaffoldKey.currentState?.openDrawer();
                          }
                        },
                      ),
              ),
              Expanded(
                child: widget.child,
              ),
            ],
          );

          return isDesktop ? CursorGlow(child: content) : content;
        },
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String label, int index) {
    final isSelected = widget.selectedIndex == index;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
      onTap: () => _navigate(context, index),
    );
  }
}