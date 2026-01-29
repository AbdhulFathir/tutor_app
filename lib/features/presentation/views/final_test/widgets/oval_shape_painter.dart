import 'package:flutter/material.dart';

class OvalShapePainter extends CustomPainter {
  final Color color;

  OvalShapePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Define the Paint properties
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 2. Define the Rect (bounding box) for the oval
    // Let's make it span the entire size of the CustomPaint widget for simplicity
    // and adjust the height to make it more oval than a full circle.
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height, // Adjust this ratio for your specific oval shape
    );

    // 3. Draw the oval on the canvas
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant OvalShapePainter oldDelegate) {
    // Only repaint if the color changes
    return oldDelegate.color != color;
  }
}