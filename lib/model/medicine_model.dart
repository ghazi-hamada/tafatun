import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineModel {
  String? id;
  String? nameMedicine;
  String? nameMedicineShort;
  String? doseMedicine;
  String? typeMedicine;
  Timestamp? startdate;
  Timestamp? stopdate;
  Timestamp? dateend;
  Timestamp? datereminder;
  int? repetition;
  bool? takeMedicine;
  int? idNotification;

  MedicineModel({
    this.id,
    this.nameMedicine,
    this.nameMedicineShort,
    this.doseMedicine,
    this.typeMedicine,
    this.startdate,
    this.stopdate,
    this.dateend,
    this.datereminder,
    this.repetition,
    this.takeMedicine,
    this.idNotification,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) => MedicineModel(
        id: json["id"],
        nameMedicine: json["nameMedicine"],
        nameMedicineShort: json["nameMedicineShort"],
        doseMedicine: json["doseMedicine"],
        typeMedicine: json["typeMedicine"],
        startdate: json["startdate"],
        stopdate: json["stopdate"],
        dateend: json["dateend"],
        datereminder: json["datereminder"],
        repetition: json["repetition"],
        takeMedicine: json["takeMedicine"],
        idNotification: json["idNotification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nameMedicine": nameMedicine,
        "nameMedicineShort": nameMedicineShort,
        "doseMedicine": doseMedicine,
        "typeMedicine": typeMedicine,
        "startdate": startdate,
        "stopdate": stopdate,
        "dateend": dateend,
        "datereminder": datereminder,
        "repetition": repetition,
        "takeMedicine": takeMedicine,
        "idNotification": idNotification,
      };
}
