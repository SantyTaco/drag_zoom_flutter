import 'package:flutter/material.dart';
import 'secondary_objects_painter.dart';
import 'main_object_painter.dart';
import 'globals.dart' as globals;
import 'package:drag_zoom_flutter/model/wall_model.dart';
import 'package:drag_zoom_flutter/model/stairs_model.dart';
import 'package:drag_zoom_flutter/model/desk_model.dart';



class IndoorMapManager extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IndoorMappManagerState();
  }
}


class IndoorMappManagerState extends State<IndoorMapManager> {
  double _zoom = 0.02545424195914335;
  Offset _offset = Offset(906.7, -1604.5);//Offset.zero;

  Offset _startingFocalPoint;
  Offset _previousOffset;
  double _previousZoom;


  @override
  void didChangeDependencies() {
    print("Set Center Inizial");
    print(Offset(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width));
    globals.center = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);//Offset(187.8, 269.9);//
    super.didChangeDependencies();
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
      // Ensure that item under the focal point stays in the same place despite zooming
      final Offset normalizedOffset = (_startingFocalPoint - _previousOffset) / _previousZoom;
      _offset = details.focalPoint - normalizedOffset * _zoom;
      print("Update");
      print(_zoom);
      print(_offset);
    });
  }

  List<Widget> createTables() {
    List<String> tablePoints = new List();
    List<List<List<String>>> xyzPointsFinal = new List();
    List<List<Offset>> offsetTablesFinal = new List();
    print("CreateTables");
    List<Desk> listDesk = globals.floor_data.desks;
    print(listDesk);
    for(int i = 0; i < listDesk.length; i++) {
      print(listDesk[i].polygon);
      String deskFormat = removeExtraPolygonCharactersTables(listDesk[i].polygon);
      print(deskFormat);
      tablePoints.add(deskFormat);
    }

    /*tablePoints.add("-27635.4415632293 -71140.53080777019, -27635.4415632293 -71826.24509348448, -27635.4415632293 -71826.24509348448, -26949.72727751501 -71826.24509348448, -26949.72727751501 -71826.24509348448, -26949.72727751501 -71140.53080777019, -26949.72727751501 -71140.53080777019, -27635.4415632293 -71140.53080777019");
    tablePoints.add("-27635.4415632293 -70409.02571979591, -27635.4415632293 -71094.7400055102, -27635.4415632293 -71094.7400055102, -26949.72727751501 -71094.7400055102, -26949.72727751501 -71094.7400055102, -26949.72727751501 -70409.02571979591, -26949.72727751501 -70409.02571979591, -27635.4415632293 -70409.02571979591");
    tablePoints.add("-27681.23236548928 -71094.7400055102, -27681.23236548928 -70409.02571979591, -27681.23236548928 -70409.02571979591, -28366.94665120357 -70409.02571979591, -28366.94665120357 -70409.02571979591, -28366.94665120357 -71094.7400055102, -28366.94665120357 -71094.7400055102, -27681.23236548928 -71094.7400055102");
    tablePoints.add("-27681.23236548928 -71826.24509348448, -27681.23236548928 -71140.53080777019, -27681.23236548928 -71140.53080777019, -28366.94665120357 -71140.53080777019, -28366.94665120357 -71140.53080777019, -28366.94665120357 -71826.24509348448, -28366.94665120357 -71826.24509348448, -27681.23236548928 -71826.24509348448");
    tablePoints.add("-25780.17654885582 -66803.07959598872, -25094.46226314152 -66803.07959598872, -25094.46226314152 -66803.07959598872, -25094.46226314152 -67488.79388170301, -25094.46226314152 -67488.79388170301, -25780.17654885582 -67488.79388170301, -25780.17654885582 -67488.79388170301, -25780.17654885582 -66803.07959598872");
    tablePoints.add("-26511.6816368301 -66803.07959598872, -25825.9673511158 -66803.07959598872, -25825.9673511158 -66803.07959598872, -25825.9673511158 -67488.79388170301, -25825.9673511158 -67488.79388170301, -26511.6816368301 -67488.79388170301, -26511.6816368301 -67488.79388170301, -26511.6816368301 -66803.07959598872");
    tablePoints.add("-27243.18672480438 -66803.07959598872, -26557.47243909008 -66803.07959598872, -26557.47243909008 -66803.07959598872, -26557.47243909008 -67488.79388170301, -26557.47243909008 -67488.79388170301, -27243.18672480438 -67488.79388170301, -27243.18672480438 -67488.79388170301, -27243.18672480438 -66803.07959598872");
    tablePoints.add("-27974.69181277866 -66803.07959598872, -27288.97752706436 -66803.07959598872, -27288.97752706436 -66803.07959598872, -27288.97752706436 -67488.79388170301, -27288.97752706436 -67488.79388170301, -27974.69181277866 -67488.79388170301, -27974.69181277866 -67488.79388170301, -27974.69181277866 -66803.07959598872");
    tablePoints.add("-27016.5878601521 -74306.73215637966, -27016.5878601521 -73621.01787066537, -27016.5878601521 -73621.01787066537, -27702.30214586639 -73621.01787066537, -27702.30214586639 -73621.01787066537, -27702.30214586639 -74306.73215637966, -27702.30214586639 -74306.73215637966, -27016.5878601521 -74306.73215637966");
    tablePoints.add("-27016.5878601521 -73575.22706840538, -27016.5878601521 -72889.51278269109, -27016.5878601521 -72889.51278269109, -27702.30214586639 -72889.51278269109, -27702.30214586639 -72889.51278269109, -27702.30214586639 -73575.22706840538, -27702.30214586639 -73575.22706840538, -27016.5878601521 -73575.22706840538");
    tablePoints.add("-26970.79705789212 -73575.22706840538, -26285.08277217782 -73575.22706840538, -26285.08277217782 -73575.22706840538, -26285.08277217782 -72889.51278269109, -26285.08277217782 -72889.51278269109, -26970.79705789212 -72889.51278269109, -26970.79705789212 -72889.51278269109, -26970.79705789212 -73575.22706840538");
    tablePoints.add("-26970.79705789212 -73621.01787066537, -26285.08277217782 -73621.01787066537, -26285.08277217782 -73621.01787066537, -26285.08277217782 -74306.73215637966, -26285.08277217782 -74306.73215637966, -26970.79705789212 -74306.73215637966, -26970.79705789212 -74306.73215637966, -26970.79705789212 -73621.01787066537");
    tablePoints.add("-26239.29196991785 -73621.01787066537, -25553.57768420355 -73621.01787066537, -25553.57768420355 -73621.01787066537, -25553.57768420355 -74306.73215637966, -25553.57768420355 -74306.73215637966, -26239.29196991785 -74306.73215637966, -26239.29196991785 -74306.73215637966, -26239.29196991785 -73621.01787066537");
    tablePoints.add("-26239.29196991785 -73575.22706840538, -25553.57768420355 -73575.22706840538, -25553.57768420355 -73575.22706840538, -25553.57768420355 -72889.51278269109, -25553.57768420355 -72889.51278269109, -26239.29196991785 -72889.51278269109, -26239.29196991785 -72889.51278269109, -26239.29196991785 -73575.22706840538");
    tablePoints.add("-25507.78688194357 -72889.51278269109, -25507.78688194357 -73575.22706840538, -25507.78688194357 -73575.22706840538, -24822.07259622928 -73575.22706840538, -24822.07259622928 -73575.22706840538, -24822.07259622928 -72889.51278269109, -24822.07259622928 -72889.51278269109, -25507.78688194357 -72889.51278269109");
    tablePoints.add("-25507.78688194357 -73621.01787066537, -25507.78688194357 -74306.73215637966, -25507.78688194357 -74306.73215637966, -24822.07259622928 -74306.73215637966, -24822.07259622928 -74306.73215637966, -24822.07259622928 -73621.01787066537, -24822.07259622928 -73621.01787066537, -25507.78688194357 -73621.01787066537");
    tablePoints.add("-25692.88209589409 -69319.49524760958, -25007.16781017979 -69319.49524760958, -25007.16781017979 -69319.49524760958, -25007.16781017979 -68633.78096189529, -25007.16781017979 -68633.78096189529, -25692.88209589409 -68633.78096189529, -25692.88209589409 -68633.78096189529, -25692.88209589409 -69319.49524760958");
    tablePoints.add("-26424.38718386835 -69319.49524760958, -25738.67289815405 -69319.49524760958, -25738.67289815405 -69319.49524760958, -25738.67289815405 -68633.78096189529, -25738.67289815405 -68633.78096189529, -26424.38718386835 -68633.78096189529, -26424.38718386835 -68633.78096189529, -26424.38718386835 -69319.49524760958");
    tablePoints.add("-26424.38718386836 -69365.28604986957, -25738.67289815406 -69365.28604986957, -25738.67289815406 -69365.28604986957, -25738.67289815406 -70051.00033558386, -25738.67289815406 -70051.00033558386, -26424.38718386836 -70051.00033558386, -26424.38718386836 -70051.00033558386, -26424.38718386836 -69365.28604986957");
    tablePoints.add("-26470.17798612834 -70051.00033558386, -26470.17798612834 -69365.28604986957, -26470.17798612834 -69365.28604986957, -27155.89227184263 -69365.28604986957, -27155.89227184263 -69365.28604986957, -27155.89227184263 -70051.00033558386, -27155.89227184263 -70051.00033558386, -26470.17798612834 -70051.00033558386");
    tablePoints.add("-43356.21530794323 -67319.25846188763, -42670.50102222894 -67319.25846188763, -42670.50102222894 -67319.25846188763, -42670.50102222894 -68004.97274760192, -42670.50102222894 -68004.97274760192, -43356.21530794323 -68004.97274760192, -43356.21530794323 -68004.97274760192, -43356.21530794323 -67319.25846188763");
    tablePoints.add("-44087.7203959175 -67273.46765962764, -43402.00611020321 -67273.46765962764, -43402.00611020321 -67273.46765962764, -43402.00611020321 -66587.75337391335, -43402.00611020321 -66587.75337391335, -44087.7203959175 -66587.75337391335, -44087.7203959175 -66587.75337391335, -44087.7203959175 -67273.46765962764");
    tablePoints.add("-49426.76950528839 -67541.01586661527, -48741.0552195741 -67541.01586661527, -48741.0552195741 -67541.01586661527, -48741.0552195741 -68226.73015232956, -48741.0552195741 -68226.73015232956, -49426.76950528839 -68226.73015232956, -49426.76950528839 -68226.73015232956, -49426.76950528839 -67541.01586661527");
    */
    xyzPointsFinal = getPoints(tablePoints);

    print("Tables points for CreateTables");

    for(int i = 0; i < xyzPointsFinal.length; i++) {
      List<Offset> offsetTables = new List();
      for(int j = 0; j < xyzPointsFinal[i].length; j++) {
        offsetTables.add(Offset(double.parse(xyzPointsFinal[i][j][0]) * _zoom, -double.parse(xyzPointsFinal[i][j][1])*_zoom));
      }
      offsetTablesFinal.add(offsetTables);
    }


    List<List<String>> dxPoints = getDxPoints(xyzPointsFinal);
    List<List<String>> dyPoints = getDyPoints(xyzPointsFinal);
    List<Offset> tablesPositions = getTablePosition(dxPoints, dyPoints);
    //List<Offset> tablesPositions = [Offset(-28366.9, 70409.0)];

    List<SecondaryObjects> listTables = new List();
    print("Positions");
    print(tablesPositions);


    for(int i=0; i <tablesPositions.length; i++){
      listTables.add(SecondaryObjects(_zoom, tablesPositions[i], offsetTablesFinal[i]));
    }

    return listTables;
  }


  List<Offset> getTablePosition(List<List<String>> dxPositions, List<List<String>> dyPositions) {
    List<Offset> tablesPositions = new List();

    for(int i = 0; i < dxPositions.length; i++) {
        print(dxPositions[i]);
        print(dyPositions[i]);
        tablesPositions.add(Offset(((double.parse(dxPositions[i][0]) + double.parse(dxPositions[i][1]))/2), -(double.parse(dyPositions[i][0]) + double.parse(dyPositions[i][1]))/2));
    }

    print("Center Table");
    print(tablesPositions);
    return tablesPositions;
  }

  List<List<String>> getDxPoints (List<List<List<String>>> xyzPointsFinal) {
    print("GetDxPoints");
    List<List<String>> setDxPointsList = new List();
    for(int i = 0; i < xyzPointsFinal.length; i++) {
      List<String> setDxPoints = new List();
        for(int  j= 0; j < xyzPointsFinal[i].length; j++) {
          setDxPoints.add(xyzPointsFinal[i][j][0]);
        }
      List<String> setDxPointsDistint = setDxPoints.toSet().toList();
        setDxPointsList.add(setDxPointsDistint);
    }
    print(setDxPointsList);
    return setDxPointsList;
  }

  List<List<String>> getDyPoints (List<List<List<String>>> xyzPointsFinal) {
    print("GetDyPoints");
    List<List<String>> setDxPointsList = new List();
    for(int i = 0; i < xyzPointsFinal.length; i++) {
      List<String> setDxPoints = new List();
      for(int  j= 0; j < xyzPointsFinal[i].length; j++) {
        setDxPoints.add(xyzPointsFinal[i][j][1]);
      }
      List<String> setDxPointsDistint = setDxPoints.toSet().toList();
      setDxPointsList.add(setDxPointsDistint);
    }
    print(setDxPointsList);
    return setDxPointsList;
  }

  String removeExtraPolygonCharacters(String polygon) {
    String removeFirstCharacters = polygon.replaceAll("POLYGON Z ((", "");
    String removeLastCharacters = removeFirstCharacters.replaceAll("))", "");
    return removeLastCharacters;
  }

  String removeExtraPolygonCharactersTables(String polygon) {
    String removeFirstCharacters = polygon.replaceAll("POLYGON ((", "");
    String removeLastCharacters = removeFirstCharacters.replaceAll("))", "");
    return removeLastCharacters;
  }

  String removeExtraLinestringCharacters(String polygon) {
    String removeFirstCharacters = polygon.replaceAll("LINESTRING Z (", "");
    String removeLastCharacters = removeFirstCharacters.replaceAll(")", "");
    return removeLastCharacters;
  }

  String removeExtraPointCharacters(String polygon) {
    String removeFirstCharacters = polygon.replaceAll("POINT Z (", "");
    String removeLastCharacters = removeFirstCharacters.replaceAll(")", "");
    return removeLastCharacters;
  }

  IndoorMapPinter createFloorPerimeter(double zoom, Offset offset) {
    List<String> floorPonits = new List();
    List<List<List<String>>> xyzPointsFinal = new List();

    print("Perimeter");
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
    print(xyzPointsFinal);

    return IndoorMapPinter(zoom: zoom, offset: offset, points: xyzPointsFinal);
  }


  List<List<List<String>>> getPoints(List<String> listStringPoints) {
    List<List<List<String>>> xyzPointsFinal = new List();


    for(int j = 0; j < listStringPoints.length; j++){
      List<String> listFloorPoints = listStringPoints[j].split(",");
      List<List<String>> xyzPoints = new List();

      for(int i = 0; i < listFloorPoints.length; i++) {
        xyzPoints.add(listFloorPoints[i].trim().split(" "));
      }
      xyzPointsFinal.add(xyzPoints);

    }
    print(xyzPointsFinal);
    return xyzPointsFinal;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          onScaleStart: _handleScaleStart,
          onScaleUpdate: _handleScaleUpdate,
          child: CustomPaint(
              painter: createFloorPerimeter(_zoom, _offset),
              child: Stack(
                  fit: StackFit.expand,
                  children:
                  createTables()
              )
          ),
        )
      ],
    );
  }
}