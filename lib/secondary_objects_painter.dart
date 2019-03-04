import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'table_painter.dart';

class SecondaryObjects extends StatefulWidget {
  double _zoom;
  Offset _table_position;
  List<Offset> _listOffsetTablePoints;

  SecondaryObjects(double zoom, Offset position, List<Offset> listOffsetTablePoints) {
    this._zoom = zoom;
    this._table_position = position;
    this._listOffsetTablePoints = listOffsetTablePoints;

  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SecondaryObjectsState();
  }
}

class SecondaryObjectsState extends State<SecondaryObjects> {
  Offset _offset_position; //Offset(globals.center.dx + widget._table_position.dx, globals.center.dy + widget._table_position.dy);

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

  /*@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _offset_position = Offset(globals.center.dx + widget._table_position.dx, globals.center.dy + widget._table_position.dy);
    super.didChangeDependencies();
  }*/

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
                  //if(tab){
                  _offset_position = Offset(_offset_position.dx + details.delta.dx/widget._zoom, _offset_position.dy + details.delta.dy/widget._zoom);
                  print(_offset_position);
                  //}
                });
              },
              child: Container(
                width: 300 * widget._zoom,
                height: 300 * widget._zoom,

                decoration:BoxDecoration(
                  color: Colors.lightGreen,
                  shape: BoxShape.circle
                ),
                child: Center(
                        child: CustomPaint(
                            painter: TablePainter(
                                zoom: widget._zoom,
                                //offset: widget._position
                                points: widget._table_position * widget._zoom, //_offset_position * widget._zoom
                                offsetTablePoints: widget._listOffsetTablePoints

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
