class EmergencyModel {
  String id;
  String name;
  String phone;
  String relation;

  EmergencyModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.relation,
  });

  factory EmergencyModel.fromJson(Map<String, dynamic> json) => EmergencyModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        relation: json["relation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "relation": relation,
      };
}
