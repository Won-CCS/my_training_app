class TrainingType {
  int id;
  String text;
  String photo_data;

  TrainingType(this.id, this.text, this.photo_data);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'text': text,
      'photo_data': photo_data,
    };
    return map;
  }

  TrainingType.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    text = map['text'];
    photo_data = map['photo_data'];
  }
}