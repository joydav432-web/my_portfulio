import 'package:flutter/material.dart';

class HoverCircleAvatar extends StatefulWidget {
  const HoverCircleAvatar({
    super.key,
    required this.image,
    this.onTap,
  });

  final String image;
  final VoidCallback? onTap;

  @override
  State<HoverCircleAvatar> createState() => _HoverCircleAvatarState();
}

class _HoverCircleAvatarState extends State<HoverCircleAvatar> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          scale: isHover ? 1.15 : 1,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isHover ? 0.75 : 1,
            child: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage(widget.image),
            ),
          ),
        ),
      ),
    );
  }
}