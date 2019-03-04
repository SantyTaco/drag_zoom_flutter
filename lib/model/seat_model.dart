class Seat {
  String uid;
  String name;
  String polygon;

  Seat({
    this.uid,
    this.name,
    this.polygon
  });

  factory Seat.fromJson(Map<String, dynamic> parsedJson){
    return Seat(
        uid: parsedJson['uid'],
        name : parsedJson['name'],
        polygon : parsedJson ['g']
    );
  }
}