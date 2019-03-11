import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:drag_zoom_flutter/model/floor_model.dart';


Future<String> _loadFloorDataAsset(int floorNumber) async {
  if(floorNumber == 1) {
    return await rootBundle.loadString('assets/floor_data.json');
  }
  if(floorNumber == 2) {
    return await rootBundle.loadString('assets/floor_data2.json');
  }
}


Future loadFloorData(int floorNumber) async {
  String jsonString = await _loadFloorDataAsset(floorNumber);
  final jsonResponse = json.decode(jsonString);
  Floor floor = new Floor.fromJson(jsonResponse);
  print("Service");
  print(floor.seats.length);
  return floor;
}