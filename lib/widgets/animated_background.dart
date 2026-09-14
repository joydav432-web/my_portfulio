import 'dart:math';
import 'package:flutter/material.dart';

/// Animated floating particles background for Hero section.
/// Particles move slowly and randomly, giving a living feel.
class AnimatedParticleBackground extends StatefulWidget {
  final int particleCount;
  final Color color;
  final Widget? child;

  const AnimatedParticleBackground({
    super.key,
    this.particleCount = 30,
    this.color = const Color(0xffF44336),
    this.child,
  });

  @override
  State<AnimatedParticleBackground> createState() =>
      _AnimatedParticleBackgroundState();
}

class _AnimatedParticleBackgroundState
    extends State<AnimatedParticleBackground> with TickerProviderStateMixin {
  late final List<_Particle> _particles;
  late final AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _particles = List.generate(
      widget.particleCount,
      (_) => _Particle.random(_random),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )
      ..addListener(() {
        for (final p in _particles) {
          p.update(0.016); // ~60fps delta
        }
        setState(() {});
      })
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Particle layer
        Positioned.fill(
          child: CustomPaint(
            painter: _ParticlePainter(
              particles: _particles,
              color: widget.color,
            ),
          ),
        ),
        // Child content on top
        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class _Particle {
  double x, y;
  double vx, vy;
  double radius;
  double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
  });

  factory _Particle.random(Random random) {
    return _Particle(
      x: random.nextDouble(),
      y: random.nextDouble(),
      vx: (random.nextDouble() - 0.5) * 0.0005,
      vy: (random.nextDouble() - 0.5) * 0.0005,
      radius: random.nextDouble() * 2.5 + 0.8,
      opacity: random.nextDouble() * 0.25 + 0.05,
    );
  }

  void update(double delta) {
    x += vx;
    y += vy;

    // Wrap around edges
    if (x < 0) x = 1.0;
    if (x > 1) x = 0.0;
    if (y < 0) y = 1.0;
    if (y > 1) y = 0.0;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Color color;

  _ParticlePainter({required this.particles, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()
        ..color = color.withOpacity(p.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(p.x * size.width, p.y * size.height),
        p.radius,
        paint,
      );
    }

    // Draw subtle connection lines between close particles
    final linePaint = Paint()
      ..strokeWidth = 0.4
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = (particles[i].x - particles[j].x) * size.width;
        final dy = (particles[i].y - particles[j].y) * size.height;
        final dist = sqrt(dx * dx + dy * dy);

        if (dist < 120) {
          final alpha = (1 - dist / 120) * 0.08;
          linePaint.color = color.withOpacity(alpha);
          canvas.drawLine(
            Offset(particles[i].x * size.width, particles[i].y * size.height),
            Offset(particles[j].x * size.width, particles[j].y * size.height),
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => true;
}
