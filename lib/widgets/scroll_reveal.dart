import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Wraps any child widget and animates it (fade + slide-up)
/// when it enters the viewport during scrolling or on page load.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;

  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 650),
    this.slideOffset = 40.0,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  bool _revealed = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: widget.duration);

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _slide = Tween<Offset>(
      begin: Offset(0, widget.slideOffset / 200),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // First check after frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (_revealed || !mounted) return;

    final ctx = context;
    final box = ctx.findRenderObject();
    if (box == null || box is! RenderBox || !box.hasSize) return;

    // Get the scroll ancestor
    final scrollable = Scrollable.maybeOf(ctx);
    if (scrollable == null) {
      // No scroll ancestor — just reveal immediately
      _triggerReveal();
      return;
    }

    final scrollableBox =
        scrollable.context.findRenderObject() as RenderBox?;
    if (scrollableBox == null) return;

    final viewportHeight = scrollableBox.size.height;
    final widgetOffset =
        box.localToGlobal(Offset.zero, ancestor: scrollableBox);

    // Reveal if top of widget is within viewport + 50px buffer
    if (widgetOffset.dy < viewportHeight + 50) {
      _triggerReveal();
    }
  }

  void _triggerReveal() {
    if (_revealed) return;
    _revealed = true;
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _checkVisibility();
        return false;
      },
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: _ScrollVisibilityDetector(
            onVisible: _triggerReveal,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// Detects when this widget becomes visible in the viewport.
class _ScrollVisibilityDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback onVisible;

  const _ScrollVisibilityDetector({
    required this.child,
    required this.onVisible,
  });

  @override
  State<_ScrollVisibilityDetector> createState() =>
      _ScrollVisibilityDetectorState();
}

class _ScrollVisibilityDetectorState extends State<_ScrollVisibilityDetector> {
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_triggered || !mounted) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) {
      _triggered = true;
      widget.onVisible();
      return;
    }

    final scrollBox =
        scrollable.context.findRenderObject() as RenderBox?;
    if (scrollBox == null) return;

    final viewportH = scrollBox.size.height;
    final pos = box.localToGlobal(Offset.zero, ancestor: scrollBox);

    if (pos.dy < viewportH + 80) {
      _triggered = true;
      widget.onVisible();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) {
        _check();
        return false;
      },
      child: widget.child,
    );
  }
}
