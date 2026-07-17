import 'package:flutter/material.dart';

import '../widget/main_layout.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      selectedIndex: 3,
      child: Center(
        child: Text("Contact Page"),
      ),
    );
  }
}