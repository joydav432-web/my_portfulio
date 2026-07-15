
import 'package:flutter/material.dart';
class HoverSkill extends StatefulWidget {
  final String text;

  const HoverSkill({
    super.key,
    required this.text,
  });

  @override
  State<HoverSkill> createState() => _HoverSkillState();
}

class _HoverSkillState extends State<HoverSkill> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          color: isHover ? const Color(0xffAA1A2B):Colors.grey.shade400,
          fontSize: 12,
          height: 1.8,
        ),
        child: Text(widget.text),
      ),
    );
  }
}