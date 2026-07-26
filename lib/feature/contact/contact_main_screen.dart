import 'package:flutter/material.dart';

import '../widget/main_layout.dart';
import 'desktop/desktop_contact.dart';
import 'mobile/mobile_contact.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 3,
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 600px cheye beshi hole Desktop layout,
            // kom hole Mobile layout dekhabe
            if (constraints.maxWidth >= 600) {
              return const DesktopContact();
            } else {
              return const MobileContact();
            }
          },
        ),
      ),
    );
  }
}