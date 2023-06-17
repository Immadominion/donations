import 'package:flutter/material.dart';

class BusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(20)),
        paint);

    final paint2 = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(20)),
        paint2);

    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.8), 20, paint2);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.8), 20, paint2);
    canvas.drawRect(
        Rect.fromLTRB(size.width * 0.25, size.height * 0.1, size.width * 0.75,
            size.height * 0.7),
        paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BusPainter(),
      child: Container(),
    );
  }
}
