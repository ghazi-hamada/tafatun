class AudioModell {
  String? id;
  String? name;
  String? audio;

  AudioModell({this.id, this.name, this.audio});

  AudioModell.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'audio': audio,
    };
  }
}
