import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

const String resumeUrl =
    "https://drive.google.com/file/d/1xLAenHOySgEI8OR1VzSakYT_S1jw6Ukk/view?usp=sharing";

Future<void> openResume(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final screenSize = MediaQuery.of(context).size;
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2C),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF62440).withOpacity(0.5)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Resume Preview",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              // Image Preview (Image.asset loads synchronously, no loadingBuilder needed)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenSize.height * 0.5,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/my_3.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[900],
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, color: Colors.white54, size: 50),
                            SizedBox(height: 10),
                            Text(
                              "Preview not available",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Action Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final Uri url = Uri.parse(resumeUrl);
                    try {
                      if (kIsWeb) {
                        await launchUrl(url, webOnlyWindowName: '_blank');
                      } else {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $e")),
                        );
                      }
                    }
                    if (context.mounted) Navigator.pop(context);
                  },
                  icon: const Icon(Icons.open_in_new, color: Colors.white),
                  label: const Text(
                    "View Full Resume",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffF62440),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}