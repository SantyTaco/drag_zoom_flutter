import 'package:flutter/material.dart';
import 'indoor_map_manager.dart';
import 'service/floor_service.dart';
import 'globals.dart' as global;
import 'package:drag_zoom_flutter/model/floor_model.dart';

void main() {

  loadFloorData().then((dynamic result) {
    print("main");
    Floor floor_data = result;
    global.floor_data = floor_data;
    print(global.floor_data.walls.length);
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}


class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
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

