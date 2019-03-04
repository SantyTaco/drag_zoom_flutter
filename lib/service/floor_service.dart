import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:drag_zoom_flutter/model/floor_model.dart';


Future<String> _loadFloorDataAsset() async {
  return await rootBundle.loadString('assets/floor_data.json');
}


Future loadFloorData() async {
  String jsonString = await _loadFloorDataAsset();
  final jsonResponse = json.decode(jsonString);
  Floor floor = new Floor.fromJson(jsonResponse);
  print("Service");
  print(floor.seats.length);
  return floor;
}