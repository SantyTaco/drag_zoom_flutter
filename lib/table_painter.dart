import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class TablePainter extends CustomPainter {
  const TablePainter({
    this.zoom,
    //this.offset,
    this.points
  });

  final double zoom;
  //final Offset offset;
  final Offset points;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero) * zoom + points;
    //globals.center = center;
    final Paint paint = Paint();
    final Path path = Path();
    List<Offset> tableOffset = new List();

    print("TablePointsPainter");
    print(zoom);

    /*for(int i = 0; i < points.length; i++) {
      tableOffset.add(Offset(center.dx + points[i].dx * zoom, center.dy + points[i].dy * zoom));
    }*/

    tableOffset = [
      Offset(points.dx-30*zoom, points.dy-30*zoom),
      Offset(points.dx+30*zoom, points.dy-30*zoom),
      Offset(points.dx+30*zoom, points.dy+30*zoom),
      Offset(points.dx-30*zoom, points.dy+30*zoom),
    ];

    print(tableOffset);
    print(" ");
    path.addPolygon(tableOffset, true);

    print(path);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;
    paint.strokeJoin = StrokeJoin.round;
    paint.color = Color.fromRGBO(150, 150, 150, 1.0);
    canvas.drawPath(path, paint);

  }
  @override
  bool shouldRepaint(TablePainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.zoom != zoom
        || oldDelegate.points != points;
  }
}