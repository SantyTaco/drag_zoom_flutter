import 'package:flutter/material.dart';
import 'main_object_painter.dart';
import 'globals.dart' as globals;
import 'secondary_objects_painter.dart';
import 'indoor_map_manager.dart';

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

  Offset _offset_position;//= Offset(globals.center.dx + 100.0, globals.center.dy + 250.0);
  bool tab = false;

  /*List<Widget> createTables() {
    List<Offset> tablesPositions = [Offset(100.0, 250.0),
    Offset(100.0, 300.0)];
    List<SecondaryObjects> listTables = new List();
    print(tablesPositions);

    for(int i=0; i <tablesPositions.length; i++){
      listTables.add(SecondaryObjects(_zoom, tablesPositions[i]));
    }

    return listTables;
  }*/


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Indoor Map'),
        ),
        body: IndoorMapManager()
      ),
    );
  }
}

