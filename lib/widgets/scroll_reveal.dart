import 'package:flutter/material.dart';

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

  ScrollPosition? _scrollPosition;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: Offset(0, widget.slideOffset / 200),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Initial check after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_revealed) {
      final newPosition = Scrollable.maybeOf(context)?.position;
      if (newPosition != _scrollPosition) {
        _scrollPosition?.removeListener(_checkVisibility);
        _scrollPosition = newPosition;
        _scrollPosition?.addListener(_checkVisibility);
      }
    }
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (_revealed || !mounted) return;

    final box = context.findRenderObject();
    if (box == null || box is! RenderBox || !box.hasSize) return;

    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) {
      // No scroll ancestor — reveal immediately
      _triggerReveal();
      return;
    }

    final scrollableBox =
        scrollable.context.findRenderObject() as RenderBox?;
    if (scrollableBox == null || !scrollableBox.hasSize) return;

    final viewportHeight = scrollableBox.size.height;
    final widgetOffset =
        box.localToGlobal(Offset.zero, ancestor: scrollableBox);

    // Reveal when top of widget enters viewport (with 80px anticipatory buffer)
    if (widgetOffset.dy < viewportHeight + 80) {
      _triggerReveal();
    }
  }

  void _triggerReveal() {
    if (_revealed) return;
    _revealed = true;
    _scrollPosition?.removeListener(_checkVisibility);
    _scrollPosition = null;

    if (widget.delay == Duration.zero) {
      if (mounted) _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
