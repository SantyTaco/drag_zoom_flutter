import 'package:flutter/material.dart';
import 'secondary_objects_painter.dart';
import 'main_object_painter.dart';
import 'globals.dart' as globals;



class IndoorMapManager extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IndoorMappManagerState();
  }
}


class IndoorMappManagerState extends State<IndoorMapManager> {
  double _zoom = 1;
  Offset _offset = Offset.zero;

  Offset _startingFocalPoint;
  Offset _previousOffset;
  double _previousZoom;


  @override
  void didChangeDependencies() {
    print("Set Center Inizial");
    print(Offset(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width));
    globals.center = Offset(187.8, 269.9);//Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);
    super.didChangeDependencies();
  }

  Offset _offset_position;//= Offset(globals.center.dx + 100.0, globals.center.dy + 250.0);
  bool tab = false;

  void _handleScaleStart(ScaleStartDetails details) {
    setState(() {
      _startingFocalPoint = details.focalPoint;
      _previousOffset = _offset;
      _previousZoom = _zoom;
      //_offset_position = Offset(globals.center.dx + 100.0, globals.center.dy + 250.0);

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

    /*List<Offset> tablesPositions = [Offset(187.8, 269.09)];
    //getTablePosition();
    List<SecondaryObjects> listTables = new List();
    print("List possitions");
    print(tablesPositions);
    for(int i=0; i <tablesPositions.length; i++){
      listTables.add(SecondaryObjects(_zoom,tablesPositions[i]));
    }

    return listTables;*/
    List<String> tablePoints = new List();
    List<List<List<String>>> xyzPointsFinal = new List();
    List<List<Offset>> offsetTablesFinal = new List();

    tablePoints.add("-27635.4415632293 -71140.53080777019, -27635.4415632293 -71826.24509348448, -27635.4415632293 -71826.24509348448, -26949.72727751501 -71826.24509348448, -26949.72727751501 -71826.24509348448, -26949.72727751501 -71140.53080777019, -26949.72727751501 -71140.53080777019, -27635.4415632293 -71140.53080777019");
    //tablePoints.add("-27635.4415632293 -70409.02571979591, -27635.4415632293 -71094.7400055102, -27635.4415632293 -71094.7400055102, -26949.72727751501 -71094.7400055102, -26949.72727751501 -71094.7400055102, -26949.72727751501 -70409.02571979591, -26949.72727751501 -70409.02571979591, -27635.4415632293 -70409.02571979591");
    //tablePoints.add("-27681.23236548928 -71094.7400055102, -27681.23236548928 -70409.02571979591, -27681.23236548928 -70409.02571979591, -28366.94665120357 -70409.02571979591, -28366.94665120357 -70409.02571979591, -28366.94665120357 -71094.7400055102, -28366.94665120357 -71094.7400055102, -27681.23236548928 -71094.7400055102");

    xyzPointsFinal = getPoints(tablePoints);

    print("Tables points for CreateTables");
    print(xyzPointsFinal);

    for(int i = 0; i < xyzPointsFinal.length; i++) {
      List<Offset> offsetTables = new List();
      for(int j = 0; j < xyzPointsFinal[i].length; j++) {
        offsetTables.add(Offset(double.parse(xyzPointsFinal[i][j][0]), -double.parse(xyzPointsFinal[i][j][1])));
      }
      print("XYZFinal");
      print(xyzPointsFinal[i]);
      offsetTablesFinal.add(offsetTables);
    }



    List<Offset> tablesPositions = getTablePosition(xyzPointsFinal);
    //List<Offset> tablesPositions = [Offset(187.8, 269.09), Offset(187.8, 280.0)];

    List<SecondaryObjects> listTables = new List();
    print(tablesPositions);

    for(int i=0; i <tablesPositions.length; i++){
      listTables.add(SecondaryObjects(_zoom, _offset, offsetTablesFinal[i]));
    }

    return listTables;
  }


  List<Offset> getTablePosition(List<List<List<String>>> xyzPointsFinal) {
    List<Offset> tablesPositions = new List();

    for(int i = 0; i < xyzPointsFinal.length; i++) {
      print(xyzPointsFinal[i]);
      tablesPositions.add(Offset((double.parse(xyzPointsFinal[i][2][0])), (-double.parse(xyzPointsFinal[i][0][1]))));
    }

    return tablesPositions;



  }

  IndoorMapPinter createFloorPerimeter(double zoom, Offset offset) {
    List<String> floorPonits = new List();
    List<List<List<String>>> xyzPointsFinal = new List();
    //floorPonits.add("0 0, -700 -300, 700 -300, 700 800,0 800, 0 1200,-700 1200,-700 -300");
    //floorPonits.add("-500 -100, 500 -100, 500 300,-500 300,-500 -100");

    floorPonits.add("-52024.38282852434 -74872.34950061364 20000, -52024.38282852434 -64058.48476748931 20000, -21333.00951075092 -63558.42165844208 20000, -21333.00951075092 -74872.34950061364 20000, -52024.38282852434 -74872.34950061364 20000");
    floorPonits.add("-25071.38906930248 -68832.66600068433 20000, -25071.38906930248 -68873.8777227183 20000");
    floorPonits.add("-43532.73869406105 -67992.14412169225 20000, -43532.73869406105 -68033.35584372625 20000");
    floorPonits.add("-47540.88198909858 -66558.68098154891 20000, -47540.88198909858 -66599.8927035829 20000");
    floorPonits.add("-23519.73027451359 -74872.34950061364 20000, -23519.73027451359 -71989.18248284367 20000");
    floorPonits.add("-23519.73027451359 -71989.18248284367 20000, -25630.46917717975 -71989.18248284367 20000");
    floorPonits.add("-25630.46917717975 -71989.18248284367 20000, -25630.46917717975 -69436.66819174014 20000");
    floorPonits.add("-25630.46917717975 -69436.66819174014 20000, -23481.73934396534 -69436.66819174014 20000");
    floorPonits.add("-23481.73934396534 -69436.66819174014 20000, -23519.73027451359 -66725.74672790902 20000");
    floorPonits.add("-23519.73027451359 -66725.74672790902 20000, -28031.3269665803 -66725.74672790902 20000");
    floorPonits.add("-28031.3269665803 -66725.74672790902 20000, -28031.3269665803 -66096.47349733055 20000");
    floorPonits.add("-28031.3269665803 -66096.47349733055 20000, -34751.13903275292 -66096.47349733053 20000");
    floorPonits.add("-34751.13903275292 -66096.47349733053 20000, -34751.13903275292 -63777.0469867028 20000");
    floorPonits.add("-34751.13903275292 -74872.34950061364 20000, -34751.13903275292 -72308.25586365367 20000");
    floorPonits.add("-34751.13903275292 -72308.25586365367 20000, -34201.49566953376 -72308.25586365367 20000");
    floorPonits.add("-30029.68503316759 -74872.34950061364 20000, -30029.68503316759 -72308.25586365367 20000");
    floorPonits.add("-30029.68503316759 -72308.25586365367 20000, -33143.51918582872 -72308.25586365367 20000");
    floorPonits.add("-49727.74255964598 -68191.72578594714 20000, -49727.74255964598 -68232.93750798113 20000");
    floorPonits.add("-49713.62003568462 -70711.54903058545 20000, -49713.62003568462 -70752.76075261943 20000");
    floorPonits.add("-49717.79779481543 -73338.98877125666 20000, -49717.79779481543 -73380.20049329061 20000");
    floorPonits.add("-35101.72563181992 -68191.72578594714 20000, -35101.72563181992 -68232.93750798113 20000");
    floorPonits.add("-35087.60310785855 -70711.54903058545 20000, -35087.60310785855 -70752.76075261943 20000");
    floorPonits.add("-44264.24378203533 -67992.14412169225 20000, -44264.24378203533 -68033.35584372625 20000");
    floorPonits.add("-44250.12125807397 -70511.96736633057 20000, -44250.12125807397 -70553.17908836456 20000");
    floorPonits.add("-44254.29901720479 -73139.40710700178 20000, -44254.29901720479 -73180.61882903577 20000");
    floorPonits.add("-39933.02850253767 -73062.87474586595 20000, -39933.02850253767 -73104.08646789994 20000");
    floorPonits.add("-39928.85074340684 -70435.43500519474 20000, -39928.85074340684 -70476.64672722874 20000");
    floorPonits.add("-39942.9732673682 -67915.61176055644 20000, -39942.9732673682 -67956.82348259044 20000");
    floorPonits.add("-36966.15623481759 -65338.31216196156 20000, -36966.15623481759 -65379.52388399554 20000");
    floorPonits.add("-42162.69255263312 -65386.98945739889 20000, -42162.69255263312 -65428.20117943287 20000");

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
                //createFloorPerimeter()
              )
          ),
        )
      ],
    );
  }
}