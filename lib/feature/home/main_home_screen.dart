import 'package:flutter/material.dart';
import 'package:my_portfulio/scree/home_page.dart';

import '../widget/main_layout.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      selectedIndex: 0,
      child: HomePage(),
    );
  }
}