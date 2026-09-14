import 'package:flutter/material.dart';

/// Wraps content and renders a smooth, subtle radial glow that follows
/// the desktop mouse pointer, giving a dynamic, premium feel.
class CursorGlow extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double radius;

  const CursorGlow({
    super.key,
    required this.child,
    this.glowColor = const Color(0xFFF44336),
    this.radius = 280.0,
  });

  @override
  State<CursorGlow> createState() => _CursorGlowState();
}

class _CursorGlowState extends State<CursorGlow> {
  Offset? _pointerPos;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _pointerPos = event.localPosition;
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: Stack(
        children: [
          widget.child,
          if (_isHovering && _pointerPos != null)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _GlowPainter(
                    center: _pointerPos!,
                    color: widget.glowColor,
                    radius: widget.radius,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  final Offset center;
  final Color color;
  final double radius;

  const _GlowPainter({
    required this.center,
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: 0.07),
          color.withValues(alpha: 0.03),
          color.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _GlowPainter oldDelegate) {
    return oldDelegate.center != center ||
        oldDelegate.color != color ||
        oldDelegate.radius != radius;
  }
}
