import 'package:flutter/material.dart';
import 'hover_skill.dart';

class StackCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final List<String> skills;

  const StackCard({
    super.key,
    required this.icon,
    required this.title,
    required this.skills,
  });

  @override
  State<StackCard> createState() => _StackCardState();
}

class _StackCardState extends State<StackCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _ctrl;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _glow = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
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
        animation: _glow,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            transform: _hovered
                ? (Matrix4.identity()..translate(0.0, -6.0))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              color: const Color(0xff111111),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hovered
                    ? const Color(0xffAA2E1B).withOpacity(0.6)
                    : Colors.white.withOpacity(0.07),
                width: _hovered ? 1.5 : 1,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: const Color(0xffAA2E1B)
                            .withOpacity(0.18 * _glow.value),
                        blurRadius: 24,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            padding: const EdgeInsets.all(20),
            child: child,
          );
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final iconSize = (width * .08).clamp(18.0, 24.0);
            final titleSize = (width * .05).clamp(12.0, 14.0);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      child: Icon(
                        widget.icon,
                        color: _hovered
                            ? const Color(0xffF44336)
                            : const Color(0xffAA2E1B),
                        size: iconSize,
                      ),
                    ),
                    SizedBox(width: width * .03),
                    Expanded(
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: _hovered ? Colors.white : Colors.white,
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: width * .08),
                Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: List.generate(
                    widget.skills.length,
                    (index) => HoverSkill(
                      text: index == widget.skills.length - 1
                          ? widget.skills[index]
                          : "${widget.skills[index]} /",
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
