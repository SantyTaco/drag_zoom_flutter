import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'seat_painter.dart';
class SeatObjects extends StatefulWidget {
  double _zoom;
  Offset _table_position;
  List<Offset> _listOffsetTablePoints;

  SeatObjects(double zoom, Offset position, List<Offset> listOffsetSeatPoints) {
    this._zoom = zoom;
    this._table_position = position;
    this._listOffsetTablePoints = listOffsetSeatPoints;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SeatObjectsState();
  }
}

class SeatObjectsState extends State<SeatObjects> {
  Offset _offset_position;

  @override
  void initState() {
    // TODO: implement initState
    print("Global center");
    print(globals.center);
    print(widget._table_position);
    _offset_position = Offset(widget._table_position.dx, widget._table_position.dy);
    print(_offset_position);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          left: (_offset_position.dx * widget._zoom) + globals.center.dx,
          top: (_offset_position.dy * widget._zoom) + globals.center.dy,
          child: GestureDetector(
              onTap: (){
                //tab = true;
              },
              onPanUpdate: (details) {
                setState(() {
                  print("Update");
                  _offset_position = Offset(_offset_position.dx + details.delta.dx/widget._zoom, _offset_position.dy + details.delta.dy/widget._zoom);
                  print(_offset_position);
                });
              },
              child: Container(
                  width: 300 * widget._zoom,
                  height: 300 * widget._zoom,

                  decoration:BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.rectangle
                  ),
                  child: Center(
                      child: CustomPaint(
                          painter: SeatPainter(
                              zoom: widget._zoom,
                              points: widget._table_position * widget._zoom, //_offset_position * widget._zoom
                              offsetSeatPoints: widget._listOffsetTablePoints
                          )
                      )
                  )
              )
          ),
        ),
      ],
    );
  }
}
