import 'package:flutter/material.dart';

import '../widget/main_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      selectedIndex: 1,
      child: Center(
        child: Text("about Page"),
      ),
    );
  }
}