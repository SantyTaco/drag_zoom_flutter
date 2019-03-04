class Stairs {
  String uid;
  String name;
  String polygon;

  Stairs({
    this.uid,
    this.name,
    this.polygon
  });

  factory Stairs.fromJson(Map<String, dynamic> parsedJson){
    return Stairs(
        uid: parsedJson['uid'],
        name : parsedJson['name'],
        polygon : parsedJson ['g']
    );
  }
}