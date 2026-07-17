import 'package:flutter/material.dart';
import 'package:my_portfulio/feature/contact/contact_main_screen.dart';
import 'package:my_portfulio/feature/home/main_home_screen.dart';
import 'package:my_portfulio/feature/project/project_main_screen.dart';
import 'package:my_portfulio/scree/home_page.dart';

import 'feature/about/about_main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff0C0C0C),
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const MainHomePage(),
        '/projects': (context) => const ProjectsPage(),
        '/contact': (context) => const ContactPage(),
        '/about': (context) => const AboutPage(),

      },
    );
  }
}