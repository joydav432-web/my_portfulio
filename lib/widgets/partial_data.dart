import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_portfulio/widgets/responsive.dart';
import 'package:my_portfulio/widgets/resume_button.dart';

import '../constants/colors.dart';
import '../constants/puls_ring.dart';

class PartialData extends StatefulWidget {
  const PartialData({super.key});

  @override
  State<PartialData> createState() => _PartialDataState();
}

class _PartialDataState extends State<PartialData> {
  final List<String> _roles = [
    "Flutter Developer",
    "UI/UX Designer",
    "Mobile App Expert",
    "Tech Enthusiast"
  ];
  int _roleIndex = 0;
  String _currentRole = "";
  int _charIndex = 0;
  Timer? _timer;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) return;
      setState(() {
        if (!_isDeleting) {
          if (_charIndex < _roles[_roleIndex].length) {
            _currentRole = _roles[_roleIndex].substring(0, _charIndex + 1);
            _charIndex++;
          } else {
            // Pause at the end of the word
            _timer?.cancel();
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                _isDeleting = true;
                _startTyping();
              }
            });
          }
        } else {
          if (_charIndex > 0) {
            _currentRole = _roles[_roleIndex].substring(0, _charIndex - 1);
            _charIndex--;
          } else {
            _isDeleting = false;
            _roleIndex = (_roleIndex + 1) % _roles.length;
            _timer?.cancel();
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) _startTyping();
            });
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = MediaQuery.of(context).size;
        final screenWidth = constraints.maxWidth;

        final isDesktop = isDesktopWidth(screenWidth);

        final imageSize = isDesktop
            ? responsiveSize(screenWidth, min: 170, max: 320, minWidth: 600, maxWidth: 1400)
            : responsiveSize(screenWidth, min: 140, max: 220, minWidth: 320, maxWidth: 600);

        final titleFontSize = isDesktop
            ? responsiveSize(screenWidth, min: 24, max: 38, minWidth: 600, maxWidth: 1400)
            : responsiveSize(screenWidth, min: 20, max: 28, minWidth: 320, maxWidth: 600);

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: isDesktop ? screenSize.height / 1.2 : null,
          constraints: const BoxConstraints(minHeight: 350),
          child: isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(-30 * (1 - value), 0),
                              child: child,
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Hii,\nI'm ",
                                    style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColor.whitePrimary,
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "JOY DEB",
                                    style: TextStyle(
                                      fontSize: titleFontSize + 6,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xffF62440),
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "\nA ",
                                    style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColor.whitePrimary,
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: _currentRole,
                                    style: TextStyle(
                                      fontSize: titleFontSize,
                                      fontWeight: FontWeight.w600,
                                      color: CustomColor.yellowSecondary,
                                      height: 1.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "|",
                                    style: TextStyle(
                                      fontSize: titleFontSize,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () => openResume(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffF62440),
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Resume",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 1200),
                          builder: (context, double value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.scale(
                                scale: 0.7 + (0.3 * value),
                                child: child,
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              PulseRing(
                                size: imageSize + 40,
                                color: CustomColor.yellowSecondary.withOpacity(0.15),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/my_2.jpg',
                                  width: imageSize,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 1200),
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, -20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PulseRing(
                              size: imageSize + 30,
                              color: CustomColor.yellowSecondary.withOpacity(0.12),
                            ),
                            Container(
                              width: imageSize,
                              height: imageSize * 1.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/my_2.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: child,
                          );
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Hii,\nI'm ",
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.whitePrimary,
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: "JOY DEB",
                                style: TextStyle(
                                  fontSize: titleFontSize + 4,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffF62440),
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: "\nA ",
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: CustomColor.whitePrimary,
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: _currentRole,
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: CustomColor.yellowSecondary,
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: "|",
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () => openResume(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF62440),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Resume",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
