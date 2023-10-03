import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/core/Methods/timestamptotime.dart';
import 'package:tafatun/main.dart';
import 'package:tafatun/model/medicine_model.dart';

abstract class MedicineAbinetController extends GetxController {
  serach(String p0);
  getData();
}

class MedicineAbinetControllerImp extends MedicineAbinetController {
  late TextEditingController searchController;
  List<MedicineModel> medicinedata = [];
  List<MedicineModel> itemslistMedicine = [];
  Query<Map<String, dynamic>> medicine = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("medicines");
  @override
  getData() async {
    var responsebody = await medicine.get();
    for (var element in responsebody.docs) {
      Timestamp? dateend = MedicineModel.fromJson(element.data()).dateend;
      if (!isDateBeforeNow(dateend!)) {
        medicinedata.add(MedicineModel.fromJson(element.data()));
      }
      update();
    }
    // print(medicinedata[0].nameMedicine);
  }

  // var fcm = FirebaseMessaging.instance;
  @override
  void onInit() async {
    getData();
    searchController = TextEditingController();
    super.onInit();
  }


  
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  serach(String p0) {
    itemslistMedicine = medicinedata
        .where((element) =>
            element.nameMedicine!.toLowerCase().contains(p0.toLowerCase()))
        .toList();
    if (p0.isEmpty && searchController.text.isEmpty) {
      print(itemslistMedicine.length);
    }
    update();
  }
}
