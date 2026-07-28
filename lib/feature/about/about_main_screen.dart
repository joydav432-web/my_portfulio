import 'package:flutter/material.dart';

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
                  SectionHeader(
                    label: 'ABOUT ME',
                    title: 'Flutter developer crafting modern, high-impact apps',
                  ),
                  SizedBox(height: sectionGap),
                  Container(
                    padding: EdgeInsets.all(isDesktop ? 28 : 20),
                    decoration: BoxDecoration(
                      color: const Color(0xff121212),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'I’m a Flutter developer focused on building fast, polished, and user-friendly mobile experiences that feel great from the first tap.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        height: 1.7,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    Text(
                                      'I enjoy creating thoughtful UI, tightening app performance, and connecting modern product ideas with reliable app architecture. From Firebase and REST APIs to responsive layouts and smooth interaction design, I focus on execution that feels both beautiful and practical.',
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
                                'I’m a Flutter developer focused on building fast, polished, and user-friendly mobile experiences that feel great from the first tap.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  height: 1.7,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'I enjoy creating thoughtful UI, tightening app performance, and connecting modern product ideas with reliable app architecture. From Firebase and REST APIs to responsive layouts and smooth interaction design, I focus on execution that feels both beautiful and practical.',
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
                  SizedBox(height: sectionGap),
                  if (isDesktop)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
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
                        const SizedBox(width: 20),
                        Expanded(
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
                    )
                  else
                    Column(
                      children: [
                        _InfoCard(
                          title: 'What I do',
                          items: const [
                            'Flutter & Dart app development',
                            'Responsive UI implementation',
                            'Firebase integration',
                            'REST API connectivity',
                            'State management and clean architecture',
                          ],
                        ),
                        const SizedBox(height: 16),
                        _InfoCard(
                          title: 'Focus areas',
                          items: const [
                            'Modern mobile UI systems',
                            'Smooth animations and interactions',
                            'High-quality user experience',
                            'Scalable app structure',
                            'Clean, maintainable code',
                          ],
                        ),
                      ],
                    ),
                  SizedBox(height: sectionGap),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xff171717),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
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
                  const SizedBox(height: 24),
                  isDesktop ? const DesktopFooter() : const MobileFooter(),
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

class _ProfileImageCard extends StatelessWidget {
  const _ProfileImageCard({required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: isDesktop ? 360 : 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 18,
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
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff1b1b1b),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.9),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff151515),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ...items.map(
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
    );
  }
}

