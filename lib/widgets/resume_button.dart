import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';


// Tomar GitHub raw link ekhane dao
const String resumeUrl =
    "https://raw.githubusercontent.com/joydav432-web/my_portfulio/main/resume.pdf";

Future<void> openResume(BuildContext context) async {
  final Uri url = Uri.parse(resumeUrl);

  try {
    if (kIsWeb) {
      await launchUrl(
        url,
        webOnlyWindowName: '_blank',
      );
    } else {
      final bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Resume open kora gelo na")),
        );
      }
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}