import 'dart:math';
import 'package:flutter/material.dart';

// ── Animated Particle Background Widget ──────────────────────
class ParticleBackground extends StatefulWidget {
  final Widget? child;
  const ParticleBackground({super.key, this.child});
  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _Particle {
  double x, y, vx, vy, r, opacity;
  _Particle(double w, double h)
      : x = Random().nextDouble() * w,
        y = Random().nextDouble() * h,
        vx = (Random().nextDouble() - 0.5) * 0.8,
        vy = (Random().nextDouble() - 0.5) * 0.8,
        r = Random().nextDouble() * 1.8 + 0.5,
        opacity = Random().nextDouble() * 0.5 + 0.1;

  void update(double w, double h) {
    x += vx;
    y += vy;
    if (x < 0 || x > w) vx *= -1;
    if (y < 0 || y > h) vy *= -1;
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  _ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final grad = RadialGradient(colors: [
      const Color(0xFF5038B0).withOpacity(0.18),
      const Color(0xFF1E2860).withOpacity(0.10),
      Colors.transparent,
    ]).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.35, size.height * 0.45),
        radius: size.width * 0.6));
    canvas.drawRect(Offset.zero & size, Paint()..shader = grad);

    for (final p in particles) {
      canvas.drawCircle(
        Offset(p.x, p.y),
        p.r,
        Paint()..color = const Color(0xFFC8C0FF).withOpacity(p.opacity),
      );
    }

    final linePaint = Paint()..strokeWidth = 0.5;
    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = particles[i].x - particles[j].x;
        final dy = particles[i].y - particles[j].y;
        final d = sqrt(dx * dx + dy * dy);
        if (d < 100) {
          linePaint.color =
              const Color(0xFFB4AAFF).withOpacity(0.12 * (1 - d / 100));
          canvas.drawLine(
            Offset(particles[i].x, particles[i].y),
            Offset(particles[j].x, particles[j].y),
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => true;
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  List<_Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _ctrl =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_particles.isEmpty && mounted) {
      final s = MediaQuery.of(context).size;
      _particles = List.generate(60, (_) => _Particle(s.width, s.height));
    }
  }

  @override
  void dispose() {
    _ctrl.stop();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        if (!mounted) return widget.child ?? const SizedBox();

        final size = MediaQuery.of(context).size;
        for (final p in _particles) {
          p.update(size.width, size.height);
        }
        return CustomPaint(
          painter: _ParticlePainter(_particles),
          child: widget.child,
        );
      },
    );
  }
}

// ── Hero Section ─────────────────────────────────────────────
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return isMobile ? _MobileLayout() : _DesktopLayout();
      },
    );
  }
}

// ── Desktop Layout ────────────────────────────────────────────
class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Container(
      width: double.infinity,
      height: screenSize.height / 1.2,
      constraints: const BoxConstraints(minHeight: 350),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ParticleBackground(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Left: Text
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hii,\nI'm JOY DEB\nA Flutter Developer",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      foregroundColor: const Color(0xFF1A1D2E),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Get in Touch",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),

            // Right: Photo with rings
            Stack(
              alignment: Alignment.center,
              children: [
                PulseRing(
                  size: screenWidth / 3 + 50,
                  color: const Color(0xFFFFD700).withOpacity(0.12),
                ),
                PulseRing(
                  size: screenWidth / 3 + 20,
                  color: const Color(0xFFFFD700).withOpacity(0.20),
                ),
                Container(
                  width: screenWidth / 3,
                  height: screenWidth / 3 * 1.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: const Color(0xFFFFD700).withOpacity(0.35),
                        width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFD700).withOpacity(0.12),
                        blurRadius: 40,
                        spreadRadius: 4,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                    Image.asset('assets/images/my_2.jpg', fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Mobile Layout ─────────────────────────────────────────────
class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final imageSize = w * 0.50;

        return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1D2E),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRect(
              child: ParticleBackground(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Photo
                      SizedBox(
                        width: w,
                        height: imageSize * 1.2 + 50,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PulseRing(
                              size: imageSize + 30,
                              color: const Color(0xFFFFD700).withOpacity(0.12),
                            ),
                            PulseRing(
                              size: imageSize + 12,
                              color: const Color(0xFFFFD700).withOpacity(0.20),
                            ),
                            Container(
                              width: imageSize,
                              height: imageSize * 1.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: const Color(0xFFFFD700).withOpacity(0.35),
                                    width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFFD700).withOpacity(0.12),
                                    blurRadius: 30,
                                    spreadRadius: 4,
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset('assets/images/my_2.jpg',
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Text
                      Text(
                        "Hii,\nI'm JOY DEB\nA Flutter Developer",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: w < 400 ? 22 : 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFD700),
                            foregroundColor: const Color(0xFF1A1D2E),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Get in Touch",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            );
        },
    );
  }
}

// ── Pulsing decorative ring ───────────────────────────────────
class PulseRing extends StatefulWidget {
  final double size;
  final Color color;
  const PulseRing({super.key, required this.size, required this.color});
  @override
  State<PulseRing> createState() => _PulseRingState();
}

class _PulseRingState extends State<PulseRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    _anim = Tween(begin: 0.4, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: widget.color.withOpacity(_anim.value), width: 1),
        ),
      ),
    );
  }
}