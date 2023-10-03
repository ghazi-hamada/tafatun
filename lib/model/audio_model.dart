class AudioModel {
  
  String nameAudio;

  AudioModel({required this.nameAudio});
  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      nameAudio: json['nameAudio'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameAudio': nameAudio,
    };
  }
}
