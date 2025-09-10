import 'dart:math' as math;
import 'package:flutter/widgets.dart';

double textWidth(String text) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: TextStyle(fontWeight: FontWeight.w500)),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.size.width + 8; // add a bit of padding
}
