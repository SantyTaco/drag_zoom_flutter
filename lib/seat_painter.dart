import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class SeatPainter extends CustomPainter {
  const SeatPainter({
    this.zoom,
    //this.offset,
    this.points,
    this.offsetSeatPoints
  });

  final double zoom;
  //final Offset offset;
  final Offset points;
  final List<Offset> offsetSeatPoints;

  @override
  void paint(Canvas canvas, Size size) {
    print(points);
    final Offset center = size.center(Offset.zero) * zoom + points;
    final Paint paint = Paint();
    final Path path = Path();
    List<Offset> seatOffsetList = new List();

    print("TablePointsPainter");
    print(globals.center);
    print(center);
    print(points);
    print(offsetSeatPoints);

    double result = (points.dx - offsetSeatPoints[0].dx);
    print(result);

    seatOffsetList =
    [
      Offset(-result, -result),
      Offset(result, -result),
      Offset(result, result),
      Offset(-result, result),
      Offset(-result, -result)
    ];

    print(seatOffsetList);
    print(" ");
    path.addPolygon(seatOffsetList, true);

    print(path);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3.0;
    paint.strokeJoin = StrokeJoin.bevel;
    paint.color = Colors.blueAccent;

    canvas.drawPath(path, paint);

  }
  @override
  bool shouldRepaint(SeatPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.zoom != zoom
        || oldDelegate.points != points
        ||oldDelegate.offsetSeatPoints != offsetSeatPoints;
  }
}