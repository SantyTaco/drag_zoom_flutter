class Desk {
  String uid;
  String name;
  String polygon;

  Desk({
    this.uid,
    this.name,
    this.polygon
  });

  factory Desk.fromJson(Map<String, dynamic> parsedJson){
    return Desk(
        uid: parsedJson['uid'],
        name : parsedJson['name'],
        polygon : parsedJson ['g']
    );
  }
}