import 'package:flutter/material.dart';

class SecundaryPainter extends CustomPainter {
  const SecundaryPainter({
    this.zoom,
    this.offset,
  });

  final double zoom;
  final Offset offset;


  @override
  void paint(Canvas canvas, Size size) {

    final Offset center = size.center(Offset.zero) * zoom + offset;

    /*print(center);
    print(center.dx);
    print(center.dy);*/

    final Paint paint = Paint();
    final Path path = Path();

    var points = [Offset(center.dx-50*zoom, center.dy-50*zoom),
    Offset(center.dx+50*zoom, center.dy-50*zoom),
    Offset(center.dx+50*zoom, center.dy+50*zoom),
    Offset(center.dx-50*zoom, center.dy+50*zoom),
    Offset(center.dx-50*zoom, center.dy-50*zoom)];
    path.addPolygon(points, true);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5.0;
    paint.strokeJoin = StrokeJoin.round;
    paint.color = Colors.deepOrangeAccent;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SecundaryPainter oldPainter) {
    return oldPainter.zoom != zoom
        || oldPainter.offset != offset;
  }
}