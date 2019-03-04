import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class TablePainter extends CustomPainter {
  const TablePainter({
    this.zoom,
    //this.offset,
    this.points,
    this.offsetTablePoints
  });

  final double zoom;
  //final Offset offset;
  final Offset points;
  final List<Offset> offsetTablePoints;

  @override
  void paint(Canvas canvas, Size size) {
    print(points);
    final Offset center = size.center(Offset.zero) * zoom + points;
    final Paint paint = Paint();
    final Path path = Path();
    List<Offset> tableOffset = new List();

    print("TablePointsPainter");
    print(globals.center);
    print(center);
    print(points);
    print(offsetTablePoints);

    double result = (points.dx - offsetTablePoints[0].dx);
    print(result);

    tableOffset =
    [
      Offset(-result, -result),
      Offset(result, -result),
      Offset(result, result),
      Offset(-result, result),
      Offset(-result, -result)
    ];

    print(tableOffset);
    print(" ");
    path.addPolygon(tableOffset, true);

    print(path);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3.0;
    paint.strokeJoin = StrokeJoin.bevel;
    paint.color = Colors.blueAccent;

    canvas.drawPath(path, paint);

  }
  @override
  bool shouldRepaint(TablePainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.zoom != zoom
        || oldDelegate.points != points
    ||oldDelegate.offsetTablePoints != offsetTablePoints;
  }
}