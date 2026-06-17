import 'dart:math' as math;
import 'package:flutter/material.dart';

class PulseRing extends StatelessWidget {
  final double size;
  final Color color;
  const PulseRing({super.key, this.size = 100, this.color = Colors.white});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;
  const _GlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(0.20),
            color.withOpacity(0.06),
            color.withOpacity(0.0),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF7878FF).withOpacity(0.04)
      ..strokeWidth = 0.5;
    const step = 44.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
    final dotPaint = Paint()
      ..color = const Color(0xFF9090FF).withOpacity(0.10);
    for (double x = 0; x <= size.width; x += step) {
      for (double y = 0; y <= size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1.0, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── Particle data ────────────────────────────────────────────────────────────
class _Particle {
  double x, y, vx, vy, radius, opacity;
  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
  });
}

// ─── Particle painter ─────────────────────────────────────────────────────────
class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      canvas.drawCircle(
        Offset(p.x, p.y),
        p.radius,
        Paint()..color = const Color(0xFFBBBBCC).withOpacity(p.opacity),
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => true;
}

// ─── ParticleBackground ───────────────────────────────────────────────────────
class ParticleBackground extends StatefulWidget {
  final Widget child;
  const ParticleBackground({super.key, required this.child});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final List<_Particle> _particles = [];
  final math.Random _rnd = math.Random();
  double _w = 400;
  double _h = 600;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    // ফিক্স: setState() বাদ দেওয়া হয়েছে। AnimationController নিজেই
    // প্রতি ফ্রেমে listeners-কে notify করে। AnimatedBuilder (নিচে build()-এ)
    // শুধুমাত্র particle CustomPaint rebuild করবে — পুরো Stack/widget.child
    // (Home/Skills/Projects/Contact) আর রিবিল্ড হবে না প্রতি ফ্রেমে।
    _ctrl.addListener(_update);
  }

  void _initParticles() {
    _particles.clear();
    for (int i = 0; i < 42; i++) {
      _particles.add(_Particle(
        x: _rnd.nextDouble() * _w,
        y: _rnd.nextDouble() * _h,
        vx: (_rnd.nextDouble() - 0.5) * 0.45,
        vy: (_rnd.nextDouble() - 0.5) * 0.45,
        radius: _rnd.nextDouble() * 1.5 + 0.4,
        opacity: _rnd.nextDouble() * 0.30 + 0.07,
      ));
    }
  }

  void _update() {
    if (!mounted) return;
    for (final p in _particles) {
      p.x += p.vx;
      p.y += p.vy;
      if (p.x < 0) p.x = _w;
      if (p.x > _w) p.x = 0;
      if (p.y < 0) p.y = _h;
      if (p.y > _h) p.y = 0;
    }

  }

  @override
  void dispose() {
    _ctrl.removeListener(_update);
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    _w = screen.width;
    _h = screen.height;

    if (_particles.isEmpty) _initParticles();

    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0D0D1A),
                    Color(0xFF0F0F24),
                    Color(0xFF0A1220),
                    Color(0xFF0D1A1A),
                  ],
                  stops: [0.0, 0.35, 0.7, 1.0],
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),

          Positioned.fill(
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (context, _) {
                return CustomPaint(
                  painter: _ParticlePainter(_particles),
                );
              },
            ),
          ),

          Positioned(
            top: -100,
            left: -100,
            child: _GlowOrb(size: 380, color: const Color(0xFF6355FF)),
          ),
          Positioned(
            bottom: -120,
            right: -80,
            child: _GlowOrb(size: 420, color: const Color(0xFF00C8A0)),
          ),
          Positioned(
            top: 160,
            right: -40,
            child: _GlowOrb(size: 240, color: const Color(0xFF3A7BFF)),
          ),
          Positioned(
            bottom: 80,
            left: 60,
            child: _GlowOrb(size: 180, color: const Color(0xFF8B5FFF)),
          ),

          widget.child,
        ],
      ),
    );
  }
}