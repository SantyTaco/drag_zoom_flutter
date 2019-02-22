import 'package:flutter/material.dart';
import 'main_object_painter.dart';
import 'globals.dart' as globals;


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  double _zoom = 1.0;
  Offset _offset = Offset.zero;

  Offset _startingFocalPoint;
  Offset _previousOffset;
  double _previousZoom;

  Offset _offset_position;//= Offset(globals.center.dx + 100.0, globals.center.dy + 250.0);
  Offset _offset_position2 = Offset(150.0, 300.0);
  bool tab = false;

  @override
  void initState() {
    // TODO: implement initState
 
    _offset_position = Offset(globals.center.dx + 100.0, globals.center.dy + 250.0);
    super.initState();
  }
  void _handleScaleStart(ScaleStartDetails details) {
    setState(() {
      _startingFocalPoint = details.focalPoint;
      _previousOffset = _offset;
      _previousZoom = _zoom;
    });
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _zoom = _previousZoom * details.scale;
      tab = false;
      // Ensure that item under the focal point stays in the same place despite zooming
      final Offset normalizedOffset = (_startingFocalPoint - _previousOffset) / _previousZoom;
      _offset = details.focalPoint - normalizedOffset * _zoom;

        //_offset_position = Offset(globals.center.dx + _offset_position.dx, globals.center.dy + _offset_position.dy);

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Example'),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              child: CustomPaint(
                painter: IndoorMapPinter(
                    zoom: _zoom,
                    offset: _offset
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Positioned(
                      left: (_offset_position.dx *_zoom) + globals.center.dx,
                      top: (_offset_position.dy *_zoom) + globals.center.dy,
                      child: GestureDetector(
                        onTap: (){
                          print('Tab');
                          tab = true;
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
                          width: 100 * _zoom,
                          height: 100 * _zoom,
                          color: Colors.blue,
                      )
                      ),
                    ),
                    Positioned(
                      left: _offset_position2.dx,
                      top: _offset_position2.dy,
                      child: GestureDetector(
                          onPanUpdate: (details) {

                            setState(() {
                              print('Pan2');
                              print(globals.center);
                              _offset_position2 = Offset(_offset_position2.dx + details.delta.dx, _offset_position2.dy + details.delta.dy);
                            });
                          },
                          child: Container(
                            width: 100*_zoom,
                            height: 100*_zoom,
                            color: Colors.deepOrange,
                          )
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

