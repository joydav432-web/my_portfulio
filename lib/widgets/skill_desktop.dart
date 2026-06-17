import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/skill_item.dart';

class SkillDesktop extends StatelessWidget {
  const SkillDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 450,
          ),
          child: Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: [
              for (int i = 0; i < platformItems.length; i++)
                _HoverGlowCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    leading: Image.asset(platformItems[i]["img"]),
                    title: Text(platformItems[i]["title"]),
                  ),
                )
            ],
          ),
        ),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                for (int i = 0; i < skillItem.length; i++)
                  _HoverGlowChip(
                    title: skillItem[i]["title"],
                    img: skillItem[i]["img"],
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}

// Hover-glow wrapper for the platform cards
class _HoverGlowCard extends StatefulWidget {
  final Widget child;
  const _HoverGlowCard({required this.child});

  @override
  State<_HoverGlowCard> createState() => _HoverGlowCardState();
}

class _HoverGlowCardState extends State<_HoverGlowCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 200,
        decoration: BoxDecoration(
          color: CustomColor.bgLight2,
          borderRadius: BorderRadius.circular(5),
          boxShadow: _isHovering
              ? [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.6),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Colors.purpleAccent.withOpacity(0.4),
              blurRadius: 30,
              spreadRadius: 4,
              offset: const Offset(0, 0),
            ),
          ]
              : [],
          border: Border.all(
            color: _isHovering
                ? Colors.cyanAccent.withOpacity(0.8)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        transform: _isHovering
            ? (Matrix4.identity()..scale(1.03))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}

// Hover-glow wrapper for the skill chips
class _HoverGlowChip extends StatefulWidget {
  final String title;
  final String img;
  const _HoverGlowChip({required this.title, required this.img});

  @override
  State<_HoverGlowChip> createState() => _HoverGlowChipState();
}

class _HoverGlowChipState extends State<_HoverGlowChip> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isHovering
              ? [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.6),
              blurRadius: 18,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.purpleAccent.withOpacity(0.4),
              blurRadius: 26,
              spreadRadius: 3,
            ),
          ]
              : [],
        ),
        transform: _isHovering
            ? (Matrix4.identity()..scale(1.05))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        child: Chip(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          backgroundColor: _isHovering
              ? Colors.cyanAccent.withOpacity(0.15)
              : null,
          label: Text(widget.title),
          avatar: Image.asset(widget.img),
        ),
      ),
    );
  }
}