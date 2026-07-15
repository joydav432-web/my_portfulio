import 'package:flutter/material.dart';

class HireMeButton extends StatefulWidget {
  const HireMeButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  State<HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<HireMeButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        scale: _isHover ? 1.06 : 1.0,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF62440),
              foregroundColor: Colors.white,
              elevation: _isHover ? 10 : 4,
              shadowColor: const Color(0xFFF62440).withOpacity(.45),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "HIRE ME",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}