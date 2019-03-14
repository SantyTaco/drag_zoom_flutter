import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class IndoorMapPinter extends CustomPainter {
  const IndoorMapPinter({
    this.zoom,
    this.offset,
    this.points,
    this.center
  });

  final double zoom;
  final Offset offset;
  final List<List<List<String>>> points;
  final Offset center;


  @override
  void paint(Canvas canvas, Size size) {

    print("Main Painter");
    print(offset);
    //Offset center;
    //print(zoomCalled);
    print(size.center(Offset.zero));

    /*if(zoomCalled == 0) {
      center = size.center(Offset.zero) * zoom + offset;
    } else {
      center = size.center(Offset.zero) * zoom + Offset(offset.dx + (200*zoomCalled), offset.dy + (-200*zoomCalled));
    }*/


    //globals.center = center;
    print("Main Center");
    print(center);


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

      //print(path);
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 3.0;
      paint.strokeJoin = StrokeJoin.round;
      paint.color = Colors.white;
      canvas.drawPath(path, paint);
    }

    /*List<Offset> points1 = [
      Offset(center.dx+(-52024.38282852434) *zoom, center.dy+(-74872.34950061364)*zoom),
      Offset(center.dx+(-52024.38282852434) *zoom, center.dy+(-64058.48476748931)*zoom),
      Offset(center.dx+(-21333.00951075092) *zoom, center.dy+(-63558.42165844208)*zoom),
      Offset(center.dx+(-21333.00951075092) *zoom, center.dy+(-74872.34950061364)*zoom),
      Offset(center.dx+(-52024.38282852434) *zoom, center.dy+(-74872.34950061364)*zoom)];

    path.addPolygon(points1, true);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5.0;
    paint.strokeJoin = StrokeJoin.round;
    paint.color = Color.fromRGBO(150, 150, 150, 1.0);
    canvas.drawPath(path, paint);*/
  }

  @override
  bool shouldRepaint(IndoorMapPinter oldPainter) {
    return oldPainter.zoom != zoom
        || oldPainter.offset != offset;
  }
}