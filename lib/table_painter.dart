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
    //globals.center = center;
    final Paint paint = Paint();
    final Path path = Path();
    List<Offset> tableOffset = new List();
    List<Offset> tableOffsetPoints = new List();

    print("TablePointsPainter");
    print(globals.center);
    print(center);
    print(points);
    print(offsetTablePoints);

    double result = (points.dx - offsetTablePoints[0].dx);
    print(result);

    /*for(int i = 0; i < offsetTablePoints.length; i++) {
      tableOffset.add(Offset((offsetTablePoints[i].dx - offsetTablePoints[0].dx)*zoom, (offsetTablePoints[i].dy - offsetTablePoints[0].dy)*zoom));
    }*/

        /*"-27635.4415632293 -71140.53080777019, "
        "-27635.4415632293 -71826.24509348448, "
        "-27635.4415632293 -71826.24509348448, "
        "-26949.72727751501 -71826.24509348448, "
        "-26949.72727751501 -71826.24509348448, "
        "-26949.72727751501 -71140.53080777019, "
        "-26949.72727751501 -71140.53080777019, "
        "-27635.4415632293 -71140.53080777019"*/

    tableOffset =
    [
      /*Offset(tableOffsetPoints[0].dx*zoom, tableOffsetPoints[0].dy*zoom),
      Offset(tableOffsetPoints[1].dx*zoom, tableOffsetPoints[1].dy*zoom),
      Offset(tableOffsetPoints[2].dx*zoom, tableOffsetPoints[2].dy*zoom),
      Offset(tableOffsetPoints[3].dx*zoom, tableOffsetPoints[3].dy*zoom),
      Offset(tableOffsetPoints[4].dx*zoom, tableOffsetPoints[4].dy*zoom),
      Offset(tableOffsetPoints[5].dx*zoom, tableOffsetPoints[5].dy*zoom),
      Offset(tableOffsetPoints[6].dx*zoom, tableOffsetPoints[6].dy*zoom),
      Offset(tableOffsetPoints[7].dx*zoom, tableOffsetPoints[7].dy*zoom)*/
      //center,
      /*Offset(center.dx+177.8*zoom, center.dy-259.09*zoom),
      Offset(center.dx+197.8*zoom, center.dy-259.09*zoom),
      Offset(center.dx+197.8*zoom, center.dy-279.09*zoom),
      Offset(center.dx+177.8*zoom, center.dy-279.09*zoom),
      Offset(center.dx+177.8*zoom, center.dy-259.09*zoom)*/


      /*Offset(globals.center.dx+(-27635.4415632293)*zoom, globals.center.dy-(-71140.53080777019*zoom)),
      Offset(globals.center.dx+(-27635.4415632293)*zoom, globals.center.dy-(-71826.24509348448)*zoom),
      Offset(globals.center.dx+(-27635.4415632293)*zoom, globals.center.dy-(-71826.24509348448)*zoom),
      Offset(globals.center.dx+(-26949.72727751501)*zoom, globals.center.dy-(-71826.24509348448)*zoom),
      Offset(globals.center.dx+(-26949.72727751501)*zoom, globals.center.dy-(-71826.24509348448)*zoom),
      Offset(globals.center.dx+(-26949.72727751501)*zoom, globals.center.dy-(-71140.53080777019)*zoom),
      Offset(globals.center.dx+(-26949.72727751501)*zoom, globals.center.dy-(-71140.53080777019)*zoom),
      Offset(globals.center.dx+(-27635.4415632293)*zoom, globals.center.dy-(-71140.53080777019)*zoom),*/

      Offset(-result, -result),
      Offset(result, -result),
      Offset(result, result),
      Offset(-result, result),
      Offset(-result, -result)

      /*Offset(points.dx-30*zoom, points.dy-30*zoom),
      Offset(points.dx+30*zoom, points.dy-30*zoom),
      Offset(points.dx+30*zoom, points.dy+30*zoom),
      Offset(points.dx-30*zoom, points.dy+30*zoom),
      Offset(points.dx-30*zoom, points.dy-30*zoom)*/
    ];

    print(tableOffset);
    print(" ");
    path.addPolygon(tableOffset, true);

    print(path);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5.0;
    paint.strokeJoin = StrokeJoin.round;
    paint.color = Color.fromRGBO(150, 150, 150, 1.0);
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