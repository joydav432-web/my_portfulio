import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/scroll_reveal.dart';

import '../fotter/desktop_fotter.dart';
import '../fotter/mobile_fotter.dart';
import '../widget/main_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      selectedIndex: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isDesktop = width >= 700;
          final horizontalPadding = (width * 0.05).clamp(20.0, 32.0);
          final sectionGap = (width * 0.04).clamp(24.0, 40.0);

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: (width * 0.05).clamp(24.0, 48.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  ScrollReveal(
                    delay: const Duration(milliseconds: 0),
                    child: SectionHeader(
                      label: 'ABOUT ME',
                      title:
                          'Flutter developer crafting modern, high-impact apps',
                    ),
                  ),

                  SizedBox(height: sectionGap),

                  // Profile + bio card
                  ScrollReveal(
                    delay: const Duration(milliseconds: 80),
                    slideOffset: 30,
                    child: Container(
                      padding: EdgeInsets.all(isDesktop ? 28 : 20),
                      decoration: BoxDecoration(
                        color: const Color(0xff121212),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: isDesktop
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _ProfileImageCard(isDesktop: true),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "I'm a Flutter developer focused on building fast, polished, and user-friendly mobile experiences that feel great from the first tap.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          height: 1.7,
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      Text(
                                        "I enjoy creating thoughtful UI, tightening app performance, and connecting modern product ideas with reliable app architecture. From Firebase and REST APIs to responsive layouts and smooth interaction design, I focus on execution that feels both beautiful and practical.",
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 15,
                                          height: 1.7,
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: const [
                                          _Chip(label: 'Flutter'),
                                          _Chip(label: 'Dart'),
                                          _Chip(label: 'Firebase'),
                                          _Chip(label: 'UI/UX'),
                                          _Chip(label: 'REST API'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ProfileImageCard(isDesktop: false),
                                const SizedBox(height: 18),
                                Text(
                                  "I'm a Flutter developer focused on building fast, polished, and user-friendly mobile experiences that feel great from the first tap.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    height: 1.7,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "I enjoy creating thoughtful UI, tightening app performance, and connecting modern product ideas with reliable app architecture. From Firebase and REST APIs to responsive layouts and smooth interaction design, I focus on execution that feels both beautiful and practical.",
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 14,
                                    height: 1.7,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: const [
                                    _Chip(label: 'Flutter'),
                                    _Chip(label: 'Dart'),
                                    _Chip(label: 'Firebase'),
                                    _Chip(label: 'UI/UX'),
                                    _Chip(label: 'REST API'),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),

                  SizedBox(height: sectionGap),

                  // Animated stats row
                  ScrollReveal(
                    delay: const Duration(milliseconds: 60),
                    slideOffset: 25,
                    child: _StatsRow(isDesktop: isDesktop),
                  ),

                  SizedBox(height: sectionGap),

                  // Info cards
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ScrollReveal(
                            delay: const Duration(milliseconds: 0),
                            slideOffset: 25,
                            child: _InfoCard(
                              title: 'What I do',
                              items: const [
                                'Flutter & Dart app development',
                                'Responsive UI implementation',
                                'Firebase integration',
                                'REST API connectivity',
                                'State management and clean architecture',
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ScrollReveal(
                            delay: const Duration(milliseconds: 100),
                            slideOffset: 25,
                            child: _InfoCard(
                              title: 'Focus areas',
                              items: const [
                                'Modern mobile UI systems',
                                'Smooth animations and interactions',
                                'High-quality user experience',
                                'Scalable app structure',
                                'Clean, maintainable code',
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        ScrollReveal(
                          delay: const Duration(milliseconds: 0),
                          child: _InfoCard(
                            title: 'What I do',
                            items: const [
                              'Flutter & Dart app development',
                              'Responsive UI implementation',
                              'Firebase integration',
                              'REST API connectivity',
                              'State management and clean architecture',
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ScrollReveal(
                          delay: const Duration(milliseconds: 100),
                          child: _InfoCard(
                            title: 'Focus areas',
                            items: const [
                              'Modern mobile UI systems',
                              'Smooth animations and interactions',
                              'High-quality user experience',
                              'Scalable app structure',
                              'Clean, maintainable code',
                            ],
                          ),
                        ),
                      ],
                    ),

                  SizedBox(height: sectionGap),

                  // Currently building card
                  ScrollReveal(
                    delay: const Duration(milliseconds: 60),
                    slideOffset: 20,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xff171717),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.08)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Currently building',
                            style: TextStyle(
                              color: const Color(0xffAA2E1B),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Practical, user-centered applications with a strong focus on performance, clarity, and polished interface design.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isDesktop ? 18 : 15,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  isDesktop
                      ? const DesktopFooter()
                      : const MobileFooter(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Animated Stats Row ────────────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final bool isDesktop;
  const _StatsRow({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatItem(value: 3, suffix: '+', label: 'Projects Built'),
      _StatItem(value: 1, suffix: '+', label: 'Years Experience'),
      _StatItem(value: 5, suffix: '+', label: 'Technologies'),
      _StatItem(value: 100, suffix: '%', label: 'Commitment'),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 20, horizontal: isDesktop ? 24 : 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xffAA2E1B).withOpacity(0.08),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: stats
                  .map((s) => _AnimatedStatWidget(stat: s))
                  .toList(),
            )
          : Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 20,
              runSpacing: 24,
              children: stats
                  .map((s) => SizedBox(
                      width: 120, child: _AnimatedStatWidget(stat: s)))
                  .toList(),
            ),
    );
  }
}

class _StatItem {
  final int value;
  final String suffix;
  final String label;
  const _StatItem(
      {required this.value, required this.suffix, required this.label});
}

class _AnimatedStatWidget extends StatefulWidget {
  final _StatItem stat;
  const _AnimatedStatWidget({required this.stat});

  @override
  State<_AnimatedStatWidget> createState() => _AnimatedStatWidgetState();
}

class _AnimatedStatWidgetState extends State<_AnimatedStatWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<int> _countAnim;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _countAnim = IntTween(begin: 0, end: widget.stat.value)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    // Trigger after short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && !_started) {
        _started = true;
        _ctrl.forward();
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _countAnim,
      builder: (_, __) => Column(
        children: [
          Text(
            '${_countAnim.value}${widget.stat.suffix}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.stat.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.label, required this.title});

  final String label;
  final String title;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final smallFont = (width * 0.011).clamp(10.0, 13.0);
        final titleFont = (width * 0.06).clamp(28.0, 44.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xffAA2E1B),
                    fontSize: smallFont,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(width: (width * 0.02).clamp(10.0, 20.0)),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFont,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ],
        );
      },
    );
  }
}

// ── Profile Image Card ────────────────────────────────────────────────────────
class _ProfileImageCard extends StatefulWidget {
  const _ProfileImageCard({required this.isDesktop});
  final bool isDesktop;

  @override
  State<_ProfileImageCard> createState() => _ProfileImageCardState();
}

class _ProfileImageCardState extends State<_ProfileImageCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _scale = Tween<double>(begin: 1.0, end: 1.03)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: double.infinity,
          height: widget.isDesktop ? 360 : 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered
                  ? const Color(0xffAA2E1B).withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? const Color(0xffAA2E1B).withOpacity(0.15)
                    : Colors.black.withValues(alpha: 0.18),
                blurRadius: _hovered ? 30 : 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox.expand(
              child: Image.asset(
                'assets/images/my_3.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Chip ──────────────────────────────────────────────────────────────────────
class _Chip extends StatefulWidget {
  const _Chip({required this.label});
  final String label;

  @override
  State<_Chip> createState() => _ChipState();
}

class _ChipState extends State<_Chip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _hovered
              ? const Color(0xffAA2E1B).withOpacity(0.15)
              : const Color(0xff1b1b1b),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: _hovered
                ? const Color(0xffAA2E1B).withOpacity(0.5)
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ── Info Card ─────────────────────────────────────────────────────────────────
class _InfoCard extends StatefulWidget {
  const _InfoCard({required this.title, required this.items});
  final String title;
  final List<String> items;

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -4.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xff151515),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? const Color(0xffAA2E1B).withOpacity(0.35)
                : Colors.white.withValues(alpha: 0.08),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: const Color(0xffAA2E1B).withOpacity(0.10),
                    blurRadius: 24,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            ...widget.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Color(0xffAA2E1B),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
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
}
