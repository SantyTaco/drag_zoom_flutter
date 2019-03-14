import 'package:flutter/material.dart';

List<Offset> getTablePosition(List<List<String>> dxPositions, List<List<String>> dyPositions) {
  List<Offset> tablesPositions = new List();

  for(int i = 0; i < dxPositions.length; i++) {
    //print(dxPositions[i]);
    //print(dyPositions[i]);
    tablesPositions.add(Offset(((double.parse(dxPositions[i][0]) + double.parse(dxPositions[i][1]))/2), -(double.parse(dyPositions[i][0]) + double.parse(dyPositions[i][1]))/2));
  }

  print("Center Table");
  //print(tablesPositions);
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
  //print(setDxPointsList);
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
  //print(setDxPointsList);
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
  //print(xyzPointsFinal);
  return xyzPointsFinal;
}