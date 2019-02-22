import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class IndoorMapPinter extends CustomPainter {
  const IndoorMapPinter({
    this.zoom,
    this.offset,
  });

  final double zoom;
  final Offset offset;


  @override
  void paint(Canvas canvas, Size size) {

    final Offset center = size.center(Offset.zero) * zoom + offset;
    globals.center = center;

    print('Offset center');
    print(center);
    //print(center.dx);
    //print(center.dy);

    final Paint paint = Paint();
    final Path path = Path();

    var points = [Offset(center.dx-200*zoom, center.dy-200*zoom),
    Offset(center.dx+200*zoom, center.dy-200*zoom),
    Offset(center.dx+200*zoom, center.dy+200*zoom),
    Offset(center.dx-200*zoom, center.dy+200*zoom),
    Offset(center.dx-200*zoom, center.dy-200*zoom)];
    path.addPolygon(points, true);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5.0;
    paint.strokeJoin = StrokeJoin.round;
    paint.color = Color.fromRGBO(150, 150, 150, 1.0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(IndoorMapPinter oldPainter) {
    return oldPainter.zoom != zoom
        || oldPainter.offset != offset;
  }
}