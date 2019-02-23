import 'package:flutter/material.dart';
import 'main_object_painter.dart';
import 'globals.dart' as globals;
import 'secondary_objects_painter.dart';


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

  void _handleScaleStart(ScaleStartDetails details) {
    setState(() {
      _startingFocalPoint = details.focalPoint;
      _previousOffset = _offset;
      _previousZoom = _zoom;
      _offset_position = Offset(globals.center.dx + 100.0, globals.center.dy + 250.0);

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

  List<Widget> createTables() {
    List<Offset> tablesPositions = [Offset(globals.center.dx + 100.0, globals.center.dy + 250.0),
    Offset(globals.center.dx + 200.0, globals.center.dy + 250.0)];
    List<SecondaryObjects> listTables = new List();
    print(tablesPositions);

    for(int i=0; i <tablesPositions.length; i++){
      listTables.add(SecondaryObjects(_zoom, tablesPositions[i]));
    }

    return listTables;
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
                  children:
                    createTables()
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

