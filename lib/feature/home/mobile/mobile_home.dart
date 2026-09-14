import 'package:flutter/material.dart';
import 'package:my_portfulio/feature/resume/resume_viewer.dart';
import 'package:my_portfulio/widgets/typewriter_text.dart';

class MobileHero extends StatefulWidget {
  const MobileHero({super.key});

  @override
  State<MobileHero> createState() => _MobileHeroState();
}

class _MobileHeroState extends State<MobileHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entryController;
  late final Animation<double> _imageFade;
  late final Animation<Offset> _imageSlide;
  late final Animation<double> _badgeFade;
  late final Animation<Offset> _badgeSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _typewriterFade;
  late final Animation<double> _descFade;
  late final Animation<Offset> _descSlide;
  late final Animation<double> _btnFade;
  late final Animation<Offset> _btnSlide;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _imageFade = _fade(0.0, 0.30);
    _imageSlide = _slide(0.0, 0.30);
    _badgeFade = _fade(0.18, 0.42);
    _badgeSlide = _slide(0.18, 0.42);
    _titleFade = _fade(0.28, 0.52);
    _titleSlide = _slide(0.28, 0.52);
    _typewriterFade = _fade(0.38, 0.58);
    _descFade = _fade(0.46, 0.68);
    _descSlide = _slide(0.46, 0.68);
    _btnFade = _fade(0.58, 0.80);
    _btnSlide = _slide(0.58, 0.80);

    _entryController.forward();
  }

  Animation<double> _fade(double start, double end) =>
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _entryController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );

  Animation<Offset> _slide(double start, double end) =>
      Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _entryController,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final imageSize = width * .55;
        final titleSize = width * .075;
        final nameSize = width * .11;
        final buttonHeight = width * .14;

        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // Profile image
              FadeTransition(
                opacity: _imageFade,
                child: SlideTransition(
                  position: _imageSlide,
                  child: _HoverImage(
                    imageSize: imageSize.clamp(170.0, 260.0),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // Badge row
              FadeTransition(
                opacity: _badgeFade,
                child: SlideTransition(
                  position: _badgeSlide,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _PulsingDot(),
                          const SizedBox(width: 8),
                          Text(
                            "Available for work",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: (width * 0.038).clamp(11.0, 15.0),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_on_outlined,
                              color: Colors.white54, size: 15),
                          const SizedBox(width: 5),
                          Text(
                            "Dhaka Bangladesh",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: (width * 0.038).clamp(11.0, 15.0),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Title
              FadeTransition(
                opacity: _titleFade,
                child: SlideTransition(
                  position: _titleSlide,
                  child: Text(
                    "Crossplatform-Quality UI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleSize.clamp(24.0, 34.0),
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Typewriter
              FadeTransition(
                opacity: _typewriterFade,
                child: TypewriterText(
                  texts: const [
                    "Flutter Developer",
                    "Mobile UI Expert",
                    "Firebase Engineer",
                    "Clean Code Advocate",
                  ],
                  style: TextStyle(
                    fontSize: nameSize.clamp(24.0, 34.0),
                    fontWeight: FontWeight.w800,
                    color: const Color(0xffF44336),
                    height: 1.2,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Description
              FadeTransition(
                opacity: _descFade,
                child: SlideTransition(
                  position: _descSlide,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .04),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Flutter Developer with a passion for crafting elegant and responsive mobile applications.\nExperienced in Flutter, Firebase, REST API integration and clean UI implementation.\nCommitted to building scalable and high-quality software.",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: (width * 0.038).clamp(11.0, 15.0),
                        height: 1.8,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // Buttons
              FadeTransition(
                opacity: _btnFade,
                child: SlideTransition(
                  position: _btnSlide,
                  child: Column(
                    children: [
                      _MobileAnimatedButton(
                        height: buttonHeight.clamp(48.0, 58.0),
                        isPrimary: true,
                        label: "RESUME",
                        icon: Icons.download,
                        fontSize: (width * 0.04).clamp(13.0, 16.0),
                        iconSize: (width * 0.05).clamp(18.0, 24.0),
                        onPressed: () => showResumeViewer(context),
                      ),
                      const SizedBox(height: 15),
                      _MobileAnimatedButton(
                        height: buttonHeight.clamp(48.0, 58.0),
                        isPrimary: false,
                        label: "VIEW WORK",
                        icon: Icons.arrow_forward,
                        fontSize: (width * 0.04).clamp(13.0, 16.0),
                        iconSize: (width * 0.05).clamp(18.0, 22.0),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/projects'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Hover image ──
class _HoverImage extends StatefulWidget {
  final double imageSize;
  const _HoverImage({required this.imageSize});

  @override
  State<_HoverImage> createState() => _HoverImageState();
}

class _HoverImageState extends State<_HoverImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 260));
    _scale = Tween<double>(begin: 1.0, end: 1.04)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _ctrl.forward(),
      onExit: (_) => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) => Transform.scale(scale: _scale.value, child: child),
        child: Container(
          width: widget.imageSize,
          height: widget.imageSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage("assets/images/my_3.png"),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF5C5C).withOpacity(.15),
                blurRadius: 20,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.white.withOpacity(.04),
                blurRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Pulsing dot ──
class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
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
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(_anim.value),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(_anim.value * 0.5),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Mobile animated button ──
class _MobileAnimatedButton extends StatefulWidget {
  final double height;
  final bool isPrimary;
  final String label;
  final IconData icon;
  final double fontSize;
  final double iconSize;
  final VoidCallback onPressed;

  const _MobileAnimatedButton({
    required this.height,
    required this.isPrimary,
    required this.label,
    required this.icon,
    required this.fontSize,
    required this.iconSize,
    required this.onPressed,
  });

  @override
  State<_MobileAnimatedButton> createState() => _MobileAnimatedButtonState();
}

class _MobileAnimatedButtonState extends State<_MobileAnimatedButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        height: widget.height,
        transform: _pressed
            ? (Matrix4.identity()..scale(0.97))
            : Matrix4.identity(),
        decoration: widget.isPrimary
            ? BoxDecoration(
                color: const Color(0xffF44336),
                borderRadius: BorderRadius.circular(10),
                boxShadow: _pressed
                    ? []
                    : [
                        BoxShadow(
                          color: const Color(0xffF44336).withOpacity(0.35),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(.2)),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: Colors.white, size: widget.iconSize),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: widget.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
