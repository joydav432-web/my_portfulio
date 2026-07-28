import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void showResumeViewer(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: const ResumeViewerPage(),
          ),
        );
      },
    ),
  );
}

class ResumeViewerPage extends StatefulWidget {
  const ResumeViewerPage({super.key});

  @override
  State<ResumeViewerPage> createState() => _ResumeViewerPageState();
}

class _ResumeViewerPageState extends State<ResumeViewerPage> {
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  static const _accentColor = Color(0xFFE84C3D);

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      await rootBundle.load('assets/pdf/joy_resume.pdf');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  Future<void> _openInBrowser() async {
    final uri = Uri.parse('https://drive.google.com/file/d/1Ems9TMWkw_aXC40VDRao3nhW8AfhBI9S/view?usp=sharing');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open resume link.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f10),
      appBar: AppBar(
        backgroundColor: const Color(0xff0f0f10),
        elevation: 0,
        title: const Text('Resume'),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            onPressed: _openInBrowser,
            icon: const Icon(Icons.open_in_new),
            tooltip: 'Open in browser',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: _accentColor))
          : _hasError
              ? _buildErrorState()
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Card(
                      color: const Color(0xff171717),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.description_outlined, color: _accentColor, size: 48),
                            const SizedBox(height: 16),
                            const Text(
                              'Resume PDF is ready',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Your resume file is available locally. Open it in a browser to view the full PDF.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white70, height: 1.5),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: _openInBrowser,
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('Open Resume'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _accentColor,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: _accentColor, size: 56),
            const SizedBox(height: 16),
            const Text(
              'Resume load hoy nai 😕',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage.isEmpty
                  ? 'Please check that assets/pdf/joy_resume.pdf exists.'
                  : _errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _loadPdf,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _accentColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
