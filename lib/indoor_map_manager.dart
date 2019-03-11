import 'package:flutter/material.dart';
import 'secondary_objects_painter.dart';
import 'main_object_painter.dart';
import 'globals.dart' as globals;
import 'package:drag_zoom_flutter/model/wall_model.dart';
import 'package:drag_zoom_flutter/model/stairs_model.dart';
import 'package:drag_zoom_flutter/model/desk_model.dart';
import 'package:drag_zoom_flutter/model/seat_model.dart';
import 'seats_objects_painter.dart';
import 'package:drag_zoom_flutter/Controller/utils.dart';



class IndoorMapManager extends StatefulWidget {
  double zoom;

  IndoorMapManager(double zoomReceived) {
    this.zoom = zoomReceived;
  }

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IndoorMappManagerState();
  }
}


class IndoorMappManagerState extends State<IndoorMapManager> {
  double _zoom; //= 0.02545424195914335;
  Offset _offset; //= Offset(906.7, -1604.5);//Offset.zero;

  Offset _startingFocalPoint;
  Offset _previousOffset;
  double _previousZoom;

  @override
  void initState() {
    print('Initiate');
    _zoom = 0.02545424195914335;
    _offset = Offset(906.7, -1604.5);//Offset.zero;
    super.initState();
  }


  @override
  void didChangeDependencies() {
    print("Set Center Inizial");
    //print(Offset(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width));
    globals.center = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);//Offset(187.8, 269.9);//
    super.didChangeDependencies();
  }


  void _handleScaleStart(ScaleStartDetails details) {
    setState(() {
      print('ZOOM');
      print(widget.zoom);
      _startingFocalPoint = details.focalPoint;
      _previousOffset = _offset;
      _previousZoom = widget.zoom;
    });
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      //_zoom = widget.zoom * details.scale;
      // Ensure that item under the focal point stays in the same place despite zooming
      final Offset normalizedOffset = (_startingFocalPoint - _previousOffset) / _previousZoom;
      _offset = details.focalPoint - normalizedOffset * widget.zoom;
      print("Update");
      print(widget.zoom);
      print(_offset);
    });
  }

  void printCall(){

      print("test");


  }

  void callUpdate(ScaleUpdateDetails details) {
    _handleScaleUpdate(details);
  }

  List<Widget> createTables() {
    List<String> tablePoints = new List();
    List<List<List<String>>> xyzPointsFinal = new List();
    List<List<Offset>> offsetTablesFinal = new List();
    List<SecondaryObjects> listTables = new List();

    print("CreateTables");
    List<Desk> listDesk = globals.floor_data.desks;
    for(int i = 0; i < listDesk.length; i++) {
      String deskFormat = removeExtraPolygonCharactersTables(listDesk[i].polygon);
      //print(deskFormat);
      tablePoints.add(deskFormat);
    }

    List<Seat> listSeats = globals.floor_data.seats;
    for(int i = 0; i < listSeats.length; i++) {
      String seatFormat = removeExtraPolygonCharactersTables(listSeats[i].polygon);
      //print(seatFormat);
      tablePoints.add(seatFormat);
    }

    xyzPointsFinal = getPoints(tablePoints);

    for(int i = 0; i < xyzPointsFinal.length; i++) {
      List<Offset> offsetTables = new List();
      for(int j = 0; j < xyzPointsFinal[i].length; j++) {
        offsetTables.add(Offset(double.parse(xyzPointsFinal[i][j][0]) * widget.zoom, -double.parse(xyzPointsFinal[i][j][1])*widget.zoom));
      }
      offsetTablesFinal.add(offsetTables);
    }


    List<List<String>> dxPoints = getDxPoints(xyzPointsFinal);
    List<List<String>> dyPoints = getDyPoints(xyzPointsFinal);
    List<Offset> tablesPositions = getTablePosition(dxPoints, dyPoints);

    //print("Positions");
    //print(tablesPositions);


    for(int i=0; i <tablesPositions.length; i++){
      listTables.add(SecondaryObjects(widget.zoom, tablesPositions[i], offsetTablesFinal[i]));
    }

    return listTables;
  }


  List<Widget> createSeats() {
    List<String> seatPoints = new List();
    List<List<List<String>>> xyzPointsFinal = new List();
    List<List<Offset>> offsetSeatsFinal = new List();
    List<SeatObjects> listSeats = new List();

    print("CreateSeats");
    List<Seat> listSeat = globals.floor_data.seats;
    for(int i = 0; i < listSeat.length; i++) {
      print(listSeat[i].polygon);
      String seatFormat = removeExtraPolygonCharactersTables(listSeat[i].polygon);
      //print(seatFormat);
      seatPoints.add(seatFormat);
    }

    xyzPointsFinal = getPoints(seatPoints);

    for(int i = 0; i < xyzPointsFinal.length; i++) {
      List<Offset> offsetSeats = new List();
      for(int j = 0; j < xyzPointsFinal[i].length; j++) {
        offsetSeats.add(Offset(double.parse(xyzPointsFinal[i][j][0]) * _zoom, -double.parse(xyzPointsFinal[i][j][1])*_zoom));
      }
      offsetSeatsFinal.add(offsetSeats);
    }


    List<List<String>> dxPoints = getDxPoints(xyzPointsFinal);
    List<List<String>> dyPoints = getDyPoints(xyzPointsFinal);
    List<Offset> seatPositions = getTablePosition(dxPoints, dyPoints);

    //print("Positions");
    //print(seatPositions);


    for(int i=0; i <seatPositions.length; i++){
      listSeats.add(SeatObjects(_zoom, seatPositions[i], offsetSeatsFinal[i]));
    }

    return listSeats;
  }

  IndoorMapPinter createFloorPerimeter(double zoom, Offset offset) {
    List<String> floorPonits = new List();
    List<List<List<String>>> xyzPointsFinal = new List();

    print("Perimeter");
    print(zoom);
    String polygonString = globals.floor_data.perimeter.polygon;
    String polygonStringFormat = removeExtraPolygonCharacters(polygonString);
    floorPonits.add(polygonStringFormat);

    List<Wall> polygonListWall = globals.floor_data.walls;
    for(int i = 0; i < polygonListWall.length; i++) {
      String linestringWallFormat = removeExtraLinestringCharacters(polygonListWall[i].polygon);
      floorPonits.add(linestringWallFormat);
    }

    List<Stairs> polygonListStair = globals.floor_data.stairs;
    for(int i = 0; i < polygonListStair.length; i++) {
      String linestringWallFormat = removeExtraPointCharacters(polygonListStair[i].polygon);
      floorPonits.add(linestringWallFormat);
    }


    xyzPointsFinal = getPoints(floorPonits);
    //print(xyzPointsFinal);

    return IndoorMapPinter(zoom: zoom, offset: offset, points: xyzPointsFinal);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          onScaleStart: _handleScaleStart,
          onScaleUpdate: callUpdate,
          child: CustomPaint(
              painter: createFloorPerimeter(widget.zoom, _offset),
              child: Stack(
                  fit: StackFit.expand,
                  children:
                  createTables()
              )
          ),
        ),

        /*GestureDetector(
            onScaleStart: _handleScaleStart,
            onScaleUpdate: _handleScaleUpdate,
            child: Stack(
                fit: StackFit.expand,
                children:
                createSeats()
            )
        )*/

      ],
    );
  }
}