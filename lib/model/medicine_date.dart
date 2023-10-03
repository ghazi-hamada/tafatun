class MedicineDate {
  String medicineId;
  String date;

  MedicineDate({
    required this.medicineId,
    required this.date,
  });

  factory MedicineDate.fromJson(Map<String, dynamic> json) {
    return MedicineDate(
      medicineId: json['medicineId'], 
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'date': date,
    };
  }


}
