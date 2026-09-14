import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/scroll_reveal.dart';

import '../fotter/desktop_fotter.dart';
import '../fotter/mobile_fotter.dart';
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
            final isDesktop = constraints.maxWidth >= 600;

            return Column(
              children: [
                ScrollReveal(
                  child: isDesktop ? const DesktopContact() : const MobileContact(),
                ),
                ScrollReveal(
                  delay: const Duration(milliseconds: 100),
                  child: isDesktop ? const DesktopFooter() : const MobileFooter(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}