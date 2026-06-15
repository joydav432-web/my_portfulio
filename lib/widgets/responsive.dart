import 'package:flutter/material.dart';
const double kMobileBreakpoint = 600;

bool isDesktopWidth(double width) => width > kMobileBreakpoint;

/// Linearly scales a value between [min] and [max] based on [width].
/// Below [minWidth] -> [min], above [maxWidth] -> [max], in between -> interpolated.
double responsiveSize(
    double width, {
      required double min,
      required double max,
      required double minWidth,
      required double maxWidth,
    }) {
  if (width <= minWidth) return min;
  if (width >= maxWidth) return max;
  final t = (width - minWidth) / (maxWidth - minWidth);
  return min + (max - min) * t;
}