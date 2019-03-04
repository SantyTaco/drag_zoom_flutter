class Lift {
  String uid;
  String name;
  String polygon;

  Lift({
    this.uid,
    this.name,
    this.polygon
  });

  factory Lift.fromJson(Map<String, dynamic> parsedJson){
    return Lift(
        uid: parsedJson['uid'],
        name : parsedJson['name'],
        polygon : parsedJson ['g']
    );
  }
}