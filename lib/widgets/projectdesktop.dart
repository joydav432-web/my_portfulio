import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectData {
  final String number;
  final String title;
  final String description;
  final List<String> techStack;
  final List<String> imagePaths;
  final String githubUrl;

  ProjectData({
    required this.number,
    required this.title,
    required this.description,
    required this.techStack,
    required this.imagePaths,
    required this.githubUrl,
  });
}
class ProjectCard extends StatefulWidget {
  final ProjectData project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  int _idx = 0;
  bool _visible = true;
  bool _zoomed = false;
  bool _showGithub = false;
  bool _busy = false;

  late AnimationController _ghController;
  late Animation<double> _ghFade;
  late Animation<Offset> _ghSlide;

  @override
  void initState() {
    super.initState();
    _ghController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _ghFade = CurvedAnimation(parent: _ghController, curve: Curves.easeOut);
    _ghSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ghController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ghController.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    if (_busy) return;
    _busy = true;

    if (!_showGithub) {
      setState(() => _showGithub = true);
      _ghController.forward();
    }

    setState(() => _zoomed = true);
    await Future.delayed(const Duration(milliseconds: 180));

    setState(() => _visible = false);
    await Future.delayed(const Duration(milliseconds: 350));

    setState(() {
      _idx = (_idx + 1) % widget.project.imagePaths.length;
      _zoomed = false;
      _visible = true;
    });

    _busy = false;
  }

  Future<void> _launchGithub() async {
    final rawUrl = widget.project.githubUrl.trim();
    final uri = Uri.parse(rawUrl);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (_) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final images = p.imagePaths;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth.clamp(0.0, 400.0);
        final imgHeight = cardWidth * 0.85; // ~230 at 400px

        return Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: const Color(0xFF0F1624),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF1E2A3A), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _onTap,
                child: SizedBox(
                  width: double.infinity,
                  height: imgHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: AnimatedOpacity(
                          opacity: _visible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                          child: AnimatedScale(
                            scale: _zoomed ? 1.06 : 1.0,
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOut,
                            child: Image.asset(
                                    images[_idx],
                                    fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            )
                          ),
                        ),
                      ),

                      if (!_showGithub)
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.32),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: Colors.white24, width: 1),
                                ),
                                child: const Text(
                                  'Tap to see next screenshot',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Dots — top right
                      Positioned(
                        top: 10,
                        right: 10,
                        child: _DotsRow(
                            count: images.length, active: _idx),
                      ),

                      if (_showGithub)
                        Positioned(
                          bottom: 12,
                          left: 12,
                          child: FadeTransition(
                            opacity: _ghFade,
                            child: SlideTransition(
                              position: _ghSlide,
                              child: GestureDetector(
                                onTap: _launchGithub,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.75),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Colors.white24, width: 1),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      _GithubIcon(size: 16),
                                      SizedBox(width: 6),
                                      Text(
                                        'GitHub',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.layers_rounded,
                            color: Color(0xFF4B8BF5), size: 13),
                        const SizedBox(width: 5),
                        Text(
                          p.number.toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFF4B8BF5),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8), // ✅ was 8

                    // Title
                    Text(
                      p.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),

                    const SizedBox(height: 8), // ✅ was 10

                    // Description
                    Text(
                      p.description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.65),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 14), // ✅ was 18

                    Divider(
                      color: Colors.white.withOpacity(0.08),
                      height: 1,
                      thickness: 1,
                    ),

                    const SizedBox(height: 14), // ✅ was 16

                    // Tech chips
                    Wrap(
                      spacing: 6, // ✅ was 8
                      runSpacing: 6, // ✅ was 8
                      children: p.techStack
                          .map((t) => _TechChip(label: t))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
//  DOT ROW
// ─────────────────────────────────────────────
class _DotsRow extends StatelessWidget {
  final int count;
  final int active;

  const _DotsRow({required this.count, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(count, (i) {
          final isActive = i == active;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 2.5),
            width: isActive ? 16 : 5,
            height: 5,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white38,
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TECH CHIP
// ─────────────────────────────────────────────
class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip({required this.label});

  static final Map<String, IconData> _icons = {
    'Dart': Icons.code_rounded,
    'Flutter': Icons.flutter_dash,
    'Firebase': Icons.local_fire_department_rounded,
    'REST API': Icons.api_rounded,
    'RESTful APIs': Icons.api_rounded,
    'Responsive UI': Icons.devices_rounded,
    'Express.js': Icons.dns_rounded,
    'Node.js': Icons.hub_rounded,
    'MongoDB': Icons.storage_rounded,
    'JavaScript': Icons.javascript_rounded,
    'React': Icons.cyclone_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final icon = _icons[label] ?? Icons.circle_outlined;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2535),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: const Color(0xFF253045), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF4B8BF5)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFB0BEC5),
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  GITHUB ICON
// ─────────────────────────────────────────────
class _GithubIcon extends StatelessWidget {
  final double size;

  const _GithubIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GithubPainter(),
    );
  }
}

class _GithubPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final r = size.width / 2;
    final c = Offset(r, r * 0.95);

    canvas.drawCircle(c, r * 0.78, p);

    canvas.drawPath(
      Path()
        ..moveTo(c.dx - r * 0.55, c.dy - r * 0.55)
        ..lineTo(c.dx - r * 0.78, c.dy - r * 0.95)
        ..lineTo(c.dx - r * 0.25, c.dy - r * 0.72)
        ..close(),
      p,
    );

    canvas.drawPath(
      Path()
        ..moveTo(c.dx + r * 0.55, c.dy - r * 0.55)
        ..lineTo(c.dx + r * 0.78, c.dy - r * 0.95)
        ..lineTo(c.dx + r * 0.25, c.dy - r * 0.72)
        ..close(),
      p,
    );

    canvas.drawCircle(
      Offset(c.dx, c.dy + r * 0.3),
      r * 0.42,
      Paint()
        ..color = const Color(0xFF000000).withOpacity(0.75)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}