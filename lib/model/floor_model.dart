import 'package:drag_zoom_flutter/model/perimeter_model.dart';
import 'package:drag_zoom_flutter/model/seat_model.dart';
import 'package:drag_zoom_flutter/model/lifts_model.dart';
import 'package:drag_zoom_flutter/model/stairs_model.dart';
import 'package:drag_zoom_flutter/model/wall_model.dart';

class Floor {
  Perimeter perimeter;
  List<Seat> seats;
  List<Lift> lifts;
  List<Stairs> stairs;
  List<Wall> walls;

  Floor({
    this.perimeter,
    this.seats,
    this.lifts,
    this.stairs,
    this.walls
  });

  factory Floor.fromJson(Map<String, dynamic> parsedJson){
    var listSeats = parsedJson['seats'] as List;
    var listLifts = parsedJson['lifts'] as List;
    var listStairs = parsedJson['stairs'] as List;
    var listWalls = parsedJson['walls'] as List;

    List<Seat> seats = listSeats.map((i) => Seat.fromJson(i)).toList();
    List<Lift> lifts = listLifts.map((i) => Lift.fromJson(i)).toList();
    List<Stairs> stairs = listStairs.map((i) => Stairs.fromJson(i)).toList();
    List<Wall> walls = listWalls.map((i) => Wall.fromJson(i)).toList();

    return Floor(
        perimeter: Perimeter.fromJson(parsedJson['perimeters']),
        seats : seats,
        lifts: lifts,
        stairs: stairs,
        walls: walls
    );
  }
}

