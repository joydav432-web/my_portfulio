import 'dart:async';
import 'package:flutter/material.dart';

/// A widget that animates text letter by letter like a typewriter.
/// Supports looping, cursor blinking, and custom styles.
class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final TextStyle style;
  final Duration typingSpeed;
  final Duration pauseDuration;
  final bool loop;
  final bool showCursor;

  const TypewriterText({
    super.key,
    required this.texts,
    required this.style,
    this.typingSpeed = const Duration(milliseconds: 80),
    this.pauseDuration = const Duration(milliseconds: 1800),
    this.loop = true,
    this.showCursor = true,
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with SingleTickerProviderStateMixin {
  String _displayText = '';
  int _textIndex = 0;
  int _charIndex = 0;
  bool _isDeleting = false;
  bool _cursorVisible = true;

  Timer? _typingTimer;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _startCursorBlink();
    _startTyping();
  }

  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 530), (_) {
      if (mounted) setState(() => _cursorVisible = !_cursorVisible);
    });
  }

  void _startTyping() {
    _typingTimer = Timer.periodic(widget.typingSpeed, (_) {
      if (!mounted) return;

      final currentText = widget.texts[_textIndex];

      setState(() {
        if (!_isDeleting) {
          if (_charIndex < currentText.length) {
            _charIndex++;
            _displayText = currentText.substring(0, _charIndex);
          } else {
            // Pause at end before deleting
            _typingTimer?.cancel();
            Future.delayed(widget.pauseDuration, () {
              if (mounted) {
                _isDeleting = true;
                _startTyping();
              }
            });
          }
        } else {
          if (_charIndex > 0) {
            _charIndex--;
            _displayText = currentText.substring(0, _charIndex);
          } else {
            _isDeleting = false;
            _textIndex = (_textIndex + 1) % widget.texts.length;
            if (!widget.loop && _textIndex == 0) {
              _typingTimer?.cancel();
              return;
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: _displayText, style: widget.style),
          if (widget.showCursor)
            TextSpan(
              text: _cursorVisible ? '|' : ' ',
              style: widget.style.copyWith(
                color: const Color(0xffF44336),
                fontWeight: FontWeight.w300,
              ),
            ),
        ],
      ),
    );
  }
}
