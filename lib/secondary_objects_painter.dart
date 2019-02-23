import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class SecondaryObjects extends StatefulWidget {
  double _zoom;
  Offset _position;
  SecondaryObjects(double zoom, Offset position) {
    this._zoom = zoom;
    this._position = position;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SecondaryObjectsState();
  }
}

class SecondaryObjectsState extends State<SecondaryObjects> {
  Offset _offset_position;

  @override
  void initState() {
    // TODO: implement initState
    _offset_position = Offset(globals.center.dx + widget._position.dx, globals.center.dy + widget._position.dy);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned(
          left: (_offset_position.dx *widget._zoom) + globals.center.dx,
          top: (_offset_position.dy *widget._zoom) + globals.center.dy,
          child: GestureDetector(
              onTap: (){
                print('Tab');
                //tab = true;
              },
              onPanUpdate: (details) {
                setState(() {
                  print('Pan');
                  print(details.delta.dx);
                  print(details.delta.dy);
                  print(globals.center);
                  //print(tab);
                  //if(tab){
                  _offset_position = Offset(_offset_position.dx + details.delta.dx , _offset_position.dy + details.delta.dy);
                  //}
                });
              },
              child: Container(
                width: 100 * widget._zoom,
                height: 20 * widget._zoom,
                color: Colors.blue,
              )
          ),
        ),
      ],
    );
  }
}
