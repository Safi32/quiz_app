import 'dart:math';

import 'package:flutter/material.dart';

class CurvedLoadingBar extends StatelessWidget {
  final double value;
  final int size;
  final Color color;

  const CurvedLoadingBar({
    super.key,
    required this.value,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurvedLoadingBarPainter(value, size, color),
      child: const SizedBox(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class CurvedLoadingBarPainter extends CustomPainter {
  final double progress;
  final int circleSize;
  final Color color;

  CurvedLoadingBarPainter(this.progress, this.circleSize, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.0
      ..strokeCap = StrokeCap.round;

    double radius = min(size.width / circleSize, size.height / 2);
    Offset center = Offset(size.width / 2, size.height);
    double startAngle = pi;
    double sweepAngle = pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CurvedLoadingBarPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
