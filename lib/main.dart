import 'package:flutter/material.dart';
import 'indoor_map_manager.dart' as manager;
import 'service/floor_service.dart';
import 'globals.dart' as global;
import 'package:drag_zoom_flutter/model/floor_model.dart';

void main() {

  loadFloorData(1).then((dynamic result) {
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
  final customWidgetKey = new GlobalKey<manager.IndoorMappManagerState>();
  double zoom = 0.02545424195914335;
  String dropdownValue = 'One';


  void _zoomIn() {
    setState(() {
      zoom = zoom + 0.004;
    });

  }

  void _zoomOut() {
    setState(() {
      zoom = zoom - 0.004;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Indoor Map'),
          actions: <Widget>[
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  print("Drop Box");
                  dropdownValue = newValue;
                  if(newValue == 'Two') {
                    loadFloorData(2).then((dynamic result) {
                      Floor floor_data = result;
                      global.floor_data = floor_data;
                      runApp(MyApp());
                    });
                  } else {
                    loadFloorData(1).then((dynamic result) {
                      Floor floor_data = result;
                      global.floor_data = floor_data;
                      runApp(MyApp());
                    });
                  }

                });
              },
              items: <String>['One', 'Two']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
            ),
          ],
        ),
        body: manager.IndoorMapManager(zoom),
        bottomNavigationBar: Row(
          children: <Widget>[
              FlatButton(
              onPressed: _zoomIn,
              child: Icon(Icons.add_circle),
              ),
            FlatButton(
              onPressed: _zoomOut,
              child: Icon(Icons.remove_circle)
            ),

          ],
        )
      ),
    );
  }
}

