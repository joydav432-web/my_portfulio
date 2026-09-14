import 'package:flutter/material.dart';
import 'package:my_portfulio/feature/resume/resume_viewer.dart';
import 'package:my_portfulio/widgets/animated_background.dart';
import 'package:my_portfulio/widgets/typewriter_text.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({super.key});

  @override
  State<DesktopHome> createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome>
    with TickerProviderStateMixin {
  // Image hover scale
  late final AnimationController _imageController;
  late final Animation<double> _scaleAnimation;

  // Page load staggered entry animations
  late final AnimationController _entryController;
  late final Animation<double> _badgeFade;
  late final Animation<Offset> _badgeSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _typewriterFade;
  late final Animation<double> _descFade;
  late final Animation<Offset> _descSlide;
  late final Animation<double> _btnFade;
  late final Animation<Offset> _btnSlide;
  late final Animation<double> _imageFade;
  late final Animation<Offset> _imageSlide;

  @override
  void initState() {
    super.initState();

    // Image hover controller
    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
      reverseDuration: const Duration(milliseconds: 220),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeOutCubic),
    );

    // Entry stagger controller
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _badgeFade = _buildFade(0.0, 0.18);
    _badgeSlide = _buildSlide(0.0, 0.18);
    _titleFade = _buildFade(0.10, 0.35);
    _titleSlide = _buildSlide(0.10, 0.35);
    _typewriterFade = _buildFade(0.22, 0.42);
    _descFade = _buildFade(0.32, 0.58);
    _descSlide = _buildSlide(0.32, 0.58);
    _btnFade = _buildFade(0.45, 0.70);
    _btnSlide = _buildSlide(0.45, 0.70);
    _imageFade = _buildFade(0.08, 0.40);
    _imageSlide = _buildSlide(0.08, 0.40, dx: 0.05);

    _entryController.forward();
  }

  Animation<double> _buildFade(double start, double end) =>
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _entryController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );

  Animation<Offset> _buildSlide(double start, double end,
      {double dx = 0.0, double dy = 0.04}) =>
      Tween<Offset>(begin: Offset(dx, dy), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _entryController,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );

  @override
  void dispose() {
    _imageController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final topFont = (width * .010).clamp(12.0, 14.0);
        final titleFont = (width * .040).clamp(34.0, 52.0);
        final nameFont = (width * .060).clamp(48.0, 72.0);
        final bodyFont = (width * .015).clamp(15.0, 18.0);
        final imageSize = (width * .26).clamp(240.0, 340.0);
        final buttonWidth = (width * .14).clamp(150.0, 180.0);
        final gap = (width * .04).clamp(25.0, 60.0);

        return AnimatedParticleBackground(
          particleCount: 28,
          color: const Color(0xffF44336),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── LEFT CONTENT ──
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge row
                    FadeTransition(
                      opacity: _badgeFade,
                      child: SlideTransition(
                        position: _badgeSlide,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: (width * .015).clamp(8.0, 20.0),
                          runSpacing: 10,
                          children: [
                            _PulsingDot(),
                            Text(
                              "Available for work",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: topFont,
                                letterSpacing: 1,
                              ),
                            ),
                            Container(width: 1, height: 14, color: Colors.white12),
                            Icon(Icons.location_on_outlined,
                                color: Colors.white54, size: topFont + 2),
                            Text(
                              "Dhaka, Bangladesh",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: topFont),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: (width * .03).clamp(25.0, 40.0)),

                    // Static title
                    FadeTransition(
                      opacity: _titleFade,
                      child: SlideTransition(
                        position: _titleSlide,
                        child: Text(
                          "Crossplatform-Quality UI",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFont,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ),
                    ),

                    // Typewriter row
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
                          fontSize: nameFont,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xffF44336),
                          height: 1,
                        ),
                        showCursor: true,
                      ),
                    ),

                    SizedBox(height: (width * .03).clamp(25.0, 35.0)),

                    // Description
                    FadeTransition(
                      opacity: _descFade,
                      child: SlideTransition(
                        position: _descSlide,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: width * .60),
                          child: Text(
                            "Flutter Developer with a passion for crafting elegant and responsive mobile applications. "
                            "Experienced in Flutter, Firebase, API integration, and clean UI/UX implementation. "
                            "Committed to building scalable, maintainable, and high-quality software.",
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: bodyFont,
                              height: 1.7,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: (width * .035).clamp(30.0, 45.0)),

                    // Buttons
                    FadeTransition(
                      opacity: _btnFade,
                      child: SlideTransition(
                        position: _btnSlide,
                        child: Wrap(
                          spacing: (width * .015).clamp(12.0, 18.0),
                          runSpacing: 15,
                          children: [
                            _AnimatedButton(
                              width: buttonWidth,
                              isPrimary: true,
                              label: "RESUME",
                              icon: Icons.download,
                              fontSize: (width * .012).clamp(13.0, 15.0),
                              iconSize: (width * .016).clamp(18.0, 22.0),
                              onPressed: () => showResumeViewer(context),
                            ),
                            _AnimatedButton(
                              width: buttonWidth,
                              isPrimary: false,
                              label: "VIEW WORK",
                              icon: Icons.arrow_forward,
                              fontSize: (width * .012).clamp(13.0, 15.0),
                              iconSize: (width * .016).clamp(18.0, 22.0),
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/projects'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: gap),

              // ── RIGHT IMAGE ──
              Expanded(
                flex: 4,
                child: FadeTransition(
                  opacity: _imageFade,
                  child: SlideTransition(
                    position: _imageSlide,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: imageSize,
                          maxHeight: imageSize,
                        ),
                        child: MouseRegion(
                          onEnter: (_) => _imageController.forward(),
                          onExit: (_) => _imageController.reverse(),
                          child: AnimatedBuilder(
                            animation: _scaleAnimation,
                            builder: (context, child) => Transform.scale(
                              scale: _scaleAnimation.value,
                              child: child,
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: AnimatedBuilder(
                                animation: _imageController,
                                builder: (context, child) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        (width * .015).clamp(18.0, 24.0)),
                                    image: const DecorationImage(
                                      image: AssetImage("assets/images/my_3.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFF5C5C).withOpacity(
                                            .18 + _imageController.value * 0.18),
                                        blurRadius:
                                            24 + _imageController.value * 16,
                                        spreadRadius: 3,
                                        offset: const Offset(0, 12),
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.35),
                                        blurRadius: 30,
                                        offset: const Offset(0, 18),
                                      ),
                                    ],
                                  ),
                                  child: child,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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

// ── Pulsing green dot ──
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
    _anim = Tween<double>(begin: 0.5, end: 1.0).animate(
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
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(_anim.value),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(_anim.value * 0.6),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Animated hover button ──
class _AnimatedButton extends StatefulWidget {
  final double width;
  final bool isPrimary;
  final String label;
  final IconData icon;
  final double fontSize;
  final double iconSize;
  final VoidCallback onPressed;

  const _AnimatedButton({
    required this.width,
    required this.isPrimary,
    required this.label,
    required this.icon,
    required this.fontSize,
    required this.iconSize,
    required this.onPressed,
  });

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        width: widget.width,
        height: 60,
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -3.0))
            : Matrix4.identity(),
        decoration: widget.isPrimary
            ? BoxDecoration(
                color: const Color(0xffF44336),
                borderRadius: BorderRadius.circular(10),
                boxShadow: _hovered
                    ? [
                        BoxShadow(
                          color: const Color(0xffF44336).withOpacity(0.45),
                          blurRadius: 20,
                          spreadRadius: 1,
                          offset: const Offset(0, 8),
                        ),
                      ]
                    : [],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _hovered
                      ? Colors.white.withOpacity(.5)
                      : Colors.white.withOpacity(.20),
                ),
                color: _hovered
                    ? Colors.white.withOpacity(0.05)
                    : Colors.transparent,
              ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: widget.onPressed,
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
        ),
      ),
    );
  }
}
