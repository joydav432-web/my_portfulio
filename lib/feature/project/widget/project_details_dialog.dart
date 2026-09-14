import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'desktop_project_card.dart';

/// Opens a rich, interactive modal dialog showing enlarged project image,
/// technologies used, in-depth description, and key benefits.
void showProjectDetailsDialog(BuildContext context, ProjectData project) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'ProjectDetails',
    barrierColor: Colors.black.withValues(alpha: 0.75),
    transitionDuration: const Duration(milliseconds: 320),
    pageBuilder: (context, anim1, anim2) {
      return ProjectDetailsDialog(project: project);
    },
    transitionBuilder: (context, anim, secAnim, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8 * anim.value,
          sigmaY: 8 * anim.value,
        ),
        child: FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1.0).animate(curved),
            child: child,
          ),
        ),
      );
    },
  );
}

class ProjectDetailsDialog extends StatefulWidget {
  final ProjectData project;

  const ProjectDetailsDialog({super.key, required this.project});

  @override
  State<ProjectDetailsDialog> createState() => _ProjectDetailsDialogState();
}

class _ProjectDetailsDialogState extends State<ProjectDetailsDialog> {
  static const _accentColor = Color(0xFFE0522D);
  static const _borderColor = Colors.white12;

  Future<void> _launch(String? url) async {
    if (url == null || url.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Link is not available.")),
        );
      }
      return;
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 700;
    final dialogWidth = isDesktop ? (size.width * 0.72).clamp(650.0, 950.0) : size.width * 0.94;
    final dialogMaxHeight = size.height * 0.90;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: dialogWidth,
          constraints: BoxConstraints(maxHeight: dialogMaxHeight),
          decoration: BoxDecoration(
            color: const Color(0xFF101012),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _accentColor.withValues(alpha: 0.35),
              width: 1.4,
            ),
            boxShadow: [
              BoxShadow(
                color: _accentColor.withValues(alpha: 0.15),
                blurRadius: 40,
                spreadRadius: 4,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── MODAL HEADER ──
                _buildHeader(context),

                // ── SCROLLABLE BODY ──
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 36 : 20,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. ENLARGED PROJECT PICTURE
                        _buildEnlargedImage(),

                        const SizedBox(height: 28),

                        // 2. TITLE & CATEGORY
                        _buildTitleSection(),

                        const SizedBox(height: 24),

                        // 3. DESCRIPTION
                        _buildSectionHeader(
                          icon: Icons.description_outlined,
                          title: "PROJECT OVERVIEW",
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.project.description,
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: isDesktop ? 16 : 14,
                            height: 1.65,
                            letterSpacing: 0.2,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // 4. TECHNOLOGIES USED
                        _buildSectionHeader(
                          icon: Icons.code_rounded,
                          title: "TECHNOLOGIES & ARCHITECTURE",
                        ),
                        const SizedBox(height: 14),
                        _buildTechTags(),

                        const SizedBox(height: 32),

                        // 5. BENEFITS & KEY FEATURES (কি কি সুবিধা দিচ্ছে)
                        _buildSectionHeader(
                          icon: Icons.star_outline_rounded,
                          title: "KEY BENEFITS & FEATURES",
                        ),
                        const SizedBox(height: 14),
                        _buildBenefitsList(isDesktop),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),

                // ── MODAL FOOTER ──
                _buildFooter(context, isDesktop),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF141416),
        border: Border(bottom: BorderSide(color: _borderColor)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: _accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _accentColor.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: _accentColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "PROJECT DETAILS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded, color: Colors.white70),
            hoverColor: _accentColor.withValues(alpha: 0.2),
            splashRadius: 22,
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }

  Widget _buildEnlargedImage() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: 460),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              widget.project.imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 280,
                  color: const Color(0xFF1C1C20),
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image_outlined, color: Colors.grey, size: 48),
                      SizedBox(height: 10),
                      Text(
                        "Project Image Preview",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              right: 14,
              bottom: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.zoom_in, color: Colors.white70, size: 15),
                    SizedBox(width: 5),
                    Text(
                      "High-Res Preview",
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.project.category.toUpperCase(),
          style: TextStyle(
            color: Colors.orange.shade400,
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.project.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, color: _accentColor, size: 18),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(height: 1, color: _borderColor),
        ),
      ],
    );
  }

  Widget _buildTechTags() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: widget.project.techTags.map((tag) {
        return _TechPill(tag: tag);
      }).toList(),
    );
  }

  Widget _buildBenefitsList(bool isDesktop) {
    return Column(
      children: widget.project.bulletPoints.asMap().entries.map((entry) {
        final index = entry.key;
        final benefit = entry.value;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF151518),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: _accentColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: _accentColor,
                  size: 15,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  benefit,
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: isDesktop ? 14.5 : 13.5,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: const BoxDecoration(
        color: Color(0xFF141416),
        border: Border(top: BorderSide(color: _borderColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: const BorderSide(color: Colors.white24),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 22 : 14,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.arrow_back, size: 16),
            label: const Text(
              "CLOSE",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _launch(widget.project.serverUrl),
            style: ElevatedButton.styleFrom(
              backgroundColor: _accentColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 26 : 18,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            icon: const Icon(Icons.code_rounded, size: 17),
            label: const Text(
              "VIEW ON GITHUB",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TechPill extends StatefulWidget {
  final String tag;

  const _TechPill({required this.tag});

  @override
  State<_TechPill> createState() => _TechPillState();
}

class _TechPillState extends State<_TechPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _hovered
              ? const Color(0xFFE0522D).withValues(alpha: 0.20)
              : const Color(0xFF18181C),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered
                ? const Color(0xFFE0522D).withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.1),
            width: 1.2,
          ),
        ),
        child: Text(
          widget.tag,
          style: TextStyle(
            color: _hovered ? Colors.white : Colors.grey.shade300,
            fontSize: 13,
            fontWeight: _hovered ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
