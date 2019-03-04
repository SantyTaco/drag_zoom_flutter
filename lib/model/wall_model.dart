class Wall {
  String uid;
  String name;
  String polygon;

  Wall({
    this.uid,
    this.name,
    this.polygon
  });

  factory Wall.fromJson(Map<String, dynamic> parsedJson){
    return Wall(
        uid: parsedJson['uid'],
        name : parsedJson['name'],
        polygon : parsedJson ['g']
    );
  }
}