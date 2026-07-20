import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchProjectUrl(BuildContext context, String? url) async {
  if (url == null || url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Link does not exists")),
    );
    return;
  }

  final Uri uri = Uri.parse(url);

  final bool launched = await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );

  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Link does not exists")),
    );
  }
}


class ProjectData {
  final String category;
  final String title;
  final String description;
  final List<String> bulletPoints;
  final List<String> techTags;
  final String imagePath;
  final bool isFullStack;
  final bool isLive;
  final String? viewDetailsUrl;
  final String? liveSiteUrl;
  final String? serverUrl;

  const ProjectData({
    required this.category,
    required this.title,
    required this.description,
    required this.bulletPoints,
    required this.techTags,
    required this.imagePath,
    this.isFullStack = true,
    this.isLive = true,
    this.viewDetailsUrl,
    this.liveSiteUrl,
    this.serverUrl,
  });
}


class DesktopProjectCard extends StatelessWidget {
  final ProjectData project;

  const DesktopProjectCard({
    super.key,
    required this.project,
  });
  static const double desktopBreakpoint = 600;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= desktopBreakpoint) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: _ProjectMockupImage(
              imagePath: project.imagePath,
              isFullStack: project.isFullStack,
              isLive: project.isLive,
            ),
          ),
          const SizedBox(width: 48),

          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CategoryLabel(text: project.category),
                const SizedBox(height: 12),
                Text(
                  project.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  project.description,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),

                ...project.bulletPoints.map(
                      (point) => _BulletPoint(text: point),
                ),
                const SizedBox(height: 20),

                _TechTagsWrap(tags: project.techTags),
                const SizedBox(height: 28),

                _ActionButtonsRow(
                  onViewDetails: () =>
                      launchProjectUrl(context, project.viewDetailsUrl),
                  onGithub: () =>
                      launchProjectUrl(context, project.serverUrl),


                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectMockupImage extends StatelessWidget {
  final String imagePath;
  final bool isFullStack;
  final bool isLive;

  const _ProjectMockupImage({
    required this.imagePath,
    required this.isFullStack,
    required this.isLive,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 300,
                color: Colors.grey.shade900,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.grey,
                  size: 40,
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 12,
          bottom: 12,
          child: Row(
            children: [
              if (isFullStack) _Badge(text: "FULLSTACK", color: Colors.white24),
              if (isFullStack && isLive) const SizedBox(width: 8),
              if (isLive)
                _Badge(
                  text: "LIVE",
                  color: Colors.greenAccent.withOpacity(0.15),
                  textColor: Colors.greenAccent,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const _Badge({
    required this.text,
    required this.color,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _CategoryLabel extends StatelessWidget {
  final String text;

  const _CategoryLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.orange.shade400,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              Icons.arrow_right_alt_rounded,
              color: Colors.orange.shade400,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TechTagsWrap extends StatelessWidget {
  final List<String> tags;

  const _TechTagsWrap({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags
          .map(
            (tag) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            tag.toUpperCase(),
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      )
          .toList(),
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  final VoidCallback onViewDetails;
  final VoidCallback onGithub;

  const _ActionButtonsRow({
    required this.onViewDetails,
    required this.onGithub,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton.icon(
          onPressed: onViewDetails,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE0522D),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          icon: const Icon(Icons.north_east, size: 16),
          label: const Text(
            "VIEW DETAILS",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ),
        OutlinedButton.icon(
          onPressed: onGithub,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white24),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(Icons.public, size: 16),
          label: const Text(
            "GITHUB",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
class MobileProjectCard extends StatelessWidget {
  final ProjectData project;

  const MobileProjectCard({
    super.key,
    required this.project,
  });

  static const double desktopBreakpoint = 600;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;


    if (screenWidth > desktopBreakpoint) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProjectMockupImage(
            imagePath: project.imagePath,
            isFullStack: project.isFullStack,
            isLive: project.isLive,
          ),
          const SizedBox(height: 20),

          _CategoryLabel(text: project.category),
          const SizedBox(height: 10),
          Text(
            project.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            project.description,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),

          ...project.bulletPoints.map(
                (point) => _BulletPoint(text: point),
          ),
          const SizedBox(height: 16),

          // Tech tags
          _TechTagsWrap(tags: project.techTags),
          const SizedBox(height: 24),
          _MobileActionButtonsColumn(
            onViewDetails: () =>
                launchProjectUrl(context, project.viewDetailsUrl),
            onGithub: () => launchProjectUrl(context, project.serverUrl),


          ),
        ],
      ),
    );
  }
}

class _MobileActionButtonsColumn extends StatelessWidget {
  final VoidCallback onViewDetails;
  final VoidCallback onGithub;

  const _MobileActionButtonsColumn({
    required this.onViewDetails,
    required this.onGithub,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onViewDetails,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE0522D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            icon: const Icon(Icons.north_east, size: 16),
            label: const Text(
              "VIEW DETAILS",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onGithub,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.public, size: 15),
                label: const Text(
                  "GITHUB",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
class ResponsiveProjectCard extends StatelessWidget {
  final ProjectData project;

  const ResponsiveProjectCard({
    super.key,
    required this.project,
  });

  static const double desktopBreakpoint = 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth > desktopBreakpoint;

        if (isDesktop) {
          return DesktopProjectCard(project: project);
        } else {
          return MobileProjectCard(project: project);
        }
      },
    );
  }
}