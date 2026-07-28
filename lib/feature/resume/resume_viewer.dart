import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// ==========================================================
/// USAGE (just call this from your resume button):
///
///   onTap: () => showResumeViewer(context),
///
/// ==========================================================

class ApiUrls {
  ApiUrls._();

  // NOTE: Google Drive "view" link kaj korbe na direct.
  // Eita export=download format e convert kora hoyeche.
  static const String resumeUrl =
      'https://drive.google.com/uc?export=download&id=1Ems9TMWkw_aXC40VDRao3nhW8AfhBI9S';
}

void showResumeViewer(BuildContext context) {
  debugPrint('📄 [ResumeViewer] Opening resume viewer... url: ${ApiUrls.resumeUrl}');
  Navigator.of(context).push(
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
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
  final PdfViewerController _pdfController = PdfViewerController();
  bool _hasError = false;
  bool _isLoading = true;
  String _errorMessage = '';

  static const _accentColor = Color(0xFFE84C3D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Resume'),
        actions: _hasError
            ? null
            : [
                IconButton(
                  tooltip: 'Zoom in',
                  icon: const Icon(Icons.zoom_in),
                  onPressed: () => _pdfController.zoomLevel += 0.25,
                ),
                IconButton(
                  tooltip: 'Zoom out',
                  icon: const Icon(Icons.zoom_out),
                  onPressed: () => _pdfController.zoomLevel -= 0.25,
                ),
              ],
      ),
      body: Stack(
        children: [
          if (!_hasError)
            SfPdfViewer.network(
              ApiUrls.resumeUrl,
              controller: _pdfController,
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                debugPrint(
                  '✅ [ResumeViewer] PDF loaded successfully. Pages: ${details.document.pages.count}',
                );
                setState(() => _isLoading = false);
              },
              onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                // Eikhane error ta terminal e clearly dekhabe
                debugPrint('❌ [ResumeViewer] PDF load FAILED');
                debugPrint('❌ [ResumeViewer] description: ${details.description}');
                debugPrint('❌ [ResumeViewer] error: ${details.error}');
                setState(() {
                  _hasError = true;
                  _isLoading = false;
                  _errorMessage = details.description;
                });
              },
            ),
          if (_isLoading && !_hasError)
            const Center(
              child: CircularProgressIndicator(color: _accentColor),
            ),
          if (_hasError) _buildErrorState(),
        ],
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
                  ? 'Unknown error — check terminal (debugPrint) for details.'
                  : _errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                debugPrint('🔄 [ResumeViewer] Retry pressed');
                setState(() {
                  _hasError = false;
                  _isLoading = true;
                });
              },
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

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }
}