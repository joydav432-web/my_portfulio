import 'package:flutter/material.dart';
import 'package:my_portfulio/scree/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfulio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),

      home: HomePage(),
    );
  }
}
