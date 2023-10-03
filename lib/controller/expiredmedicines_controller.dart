import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tafatun/core/Methods/timestamptotime.dart';
import 'package:tafatun/main.dart';
import 'package:tafatun/model/medicine_model.dart';

abstract class ExpiredMedicinesController extends GetxController {
  getData();
}

class ExpiredMedicinesControllerImp extends ExpiredMedicinesController {
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

      if (isDateBeforeNow(dateend!)) {
        medicinedata.add(MedicineModel.fromJson(element.data()));
      }
      update();
    }
  }

  @override
  void onInit() async {
    getData();
    super.onInit();
  }
}
