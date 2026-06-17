import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/skill_item.dart';

class SkillsMobile extends StatelessWidget {
  const SkillsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500.0),
      child: Column(
        children: [
          for (int i = 0; i < platformItems.length; i++)
            _TapGlowCard(
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.00,
                  horizontal: 20.00,
                ),
                leading: Image.asset(
                  platformItems[i]["img"],
                  width: 26,
                ),
                title: Text(platformItems[i]["title"]),
              ),
            ),

          SizedBox(height: 50),

          Wrap(
            spacing: 10.00,
            runSpacing: 10.00,
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < skillItem.length; i++)
                _TapGlowChip(
                  title: skillItem[i]["title"],
                  img: skillItem[i]["img"],
                )
            ],
          )
        ],
      ),
    );
  }
}

// Tap-glow wrapper for the platform cards (mobile)
class _TapGlowCard extends StatefulWidget {
  final Widget child;
  const _TapGlowCard({required this.child});

  @override
  State<_TapGlowCard> createState() => _TapGlowCardState();
}

class _TapGlowCardState extends State<_TapGlowCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(bottom: 5.00),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1B3D),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: _isPressed
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
            color: _isPressed
                ? Colors.cyanAccent.withOpacity(0.8)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        transform: _isPressed
            ? (Matrix4.identity()..scale(0.98))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}

// Tap-glow wrapper for the skill chips (mobile)
class _TapGlowChip extends StatefulWidget {
  final String title;
  final String img;
  const _TapGlowChip({required this.title, required this.img});

  @override
  State<_TapGlowChip> createState() => _TapGlowChipState();
}

class _TapGlowChipState extends State<_TapGlowChip> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isPressed
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
        transform: _isPressed
            ? (Matrix4.identity()..scale(0.96))
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        child: Chip(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ),
          backgroundColor: _isPressed
              ? Colors.cyanAccent.withOpacity(0.15)
              : null,
          label: Text(widget.title),
          avatar: Image.asset(widget.img),
        ),
      ),
    );
  }
}