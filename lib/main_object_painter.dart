import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class IndoorMapPinter extends CustomPainter {
  const IndoorMapPinter({
    this.zoom,
    this.offset,
    this.points
  });

  final double zoom;
  final Offset offset;
  final List<List<List<String>>> points;


  @override
  void paint(Canvas canvas, Size size) {

    final Offset center = size.center(Offset.zero) * zoom + offset;

    globals.center = center;
    print("Center");
    print(globals.center);


    final Paint paint = Paint();
    final Path path = Path();


    for(int i = 0; i < points.length; i++) {
      List<Offset> listOffsetPoints = new List();
      path.reset();

      for (int j = 0; j < points[i].length; j++) {
        listOffsetPoints.add(Offset(
            center.dx + double.parse(points[i][j][0]) * zoom,
            center.dy - double.parse(points[i][j][1]) * zoom));
      }
      path.addPolygon(listOffsetPoints, true);

      print(path);
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 3.0;
      paint.strokeJoin = StrokeJoin.round;
      paint.color = Colors.white;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(IndoorMapPinter oldPainter) {
    return oldPainter.zoom != zoom
        || oldPainter.offset != offset;
  }
}