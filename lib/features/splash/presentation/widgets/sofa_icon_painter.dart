import 'package:flutter/material.dart';

/// Pixel-perfect vector CustomPainter reproducing the Scandinavian sofa icon
/// from the HTML/SVG specification.
class SofaIconPainter extends CustomPainter {
  final Color color;

  const SofaIconPainter({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width / 100.0;

    // Stroke paint for outer contours
    final Paint strokePaint = Paint()
      ..color = color.withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Cushioned seat fill paint
    final Paint cushionFillPaint = Paint()
      ..color = const Color(0xFFA85C36).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    // 1. Scandinavian wooden splayed legs
    final Paint legPaint = Paint()
      ..color = color.withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5 * s
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(28 * s, 67 * s),
      Offset(21 * s, 78 * s),
      legPaint,
    );
    canvas.drawLine(
      Offset(72 * s, 67 * s),
      Offset(79 * s, 78 * s),
      legPaint,
    );

    // 2. Backrest Outer Frame
    final RRect backrest = RRect.fromRectAndRadius(
      Rect.fromLTWH(24 * s, 24 * s, 52 * s, 34 * s),
      Radius.circular(10 * s),
    );
    canvas.drawRRect(backrest, strokePaint);

    // 3. Center Divider (dashed / dotted line)
    final Paint dividerPaint = Paint()
      ..color = color.withValues(alpha: 0.60)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0 * s
      ..strokeCap = StrokeCap.round;

    final double dashHeight = 4.0 * s;
    final double dashGap = 3.0 * s;
    double currentY = 24 * s + 4 * s;
    final double endY = 56 * s;
    const double lineX = 50.0;

    while (currentY < endY) {
      final double nextY = (currentY + dashHeight).clamp(0, endY);
      canvas.drawLine(
        Offset(lineX * s, currentY),
        Offset(lineX * s, nextY),
        dividerPaint,
      );
      currentY += dashHeight + dashGap;
    }

    // 4. Cushioned Seat Base
    final RRect seatCushion = RRect.fromRectAndRadius(
      Rect.fromLTWH(22 * s, 52 * s, 56 * s, 15 * s),
      Radius.circular(7.5 * s),
    );
    canvas.drawRRect(seatCushion, cushionFillPaint);
    canvas.drawRRect(seatCushion, strokePaint);

    // 5. Armrests (Left & Right)
    final RRect leftArmrest = RRect.fromRectAndRadius(
      Rect.fromLTWH(15 * s, 42 * s, 10 * s, 25 * s),
      Radius.circular(5 * s),
    );
    canvas.drawRRect(leftArmrest, strokePaint);

    final RRect rightArmrest = RRect.fromRectAndRadius(
      Rect.fromLTWH(75 * s, 42 * s, 10 * s, 25 * s),
      Radius.circular(5 * s),
    );
    canvas.drawRRect(rightArmrest, strokePaint);
  }

  @override
  bool shouldRepaint(covariant SofaIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
