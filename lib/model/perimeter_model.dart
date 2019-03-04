class Perimeter {
  String uid;
  String name;
  String polygon;

  Perimeter({
    this.uid,
    this.name,
    this.polygon
  });

  factory Perimeter.fromJson(Map<String, dynamic> parsedJson){
    return Perimeter(
        uid: parsedJson['uid'],
        name : parsedJson['name'],
        polygon : parsedJson ['g']
    );
  }
}