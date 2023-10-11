import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tafatun/core/Methods/timestamptotime.dart';
import 'package:tafatun/main.dart';
import 'package:tafatun/model/medicine_model.dart';

abstract class ExpiredMedicinesController extends GetxController {
  getData();
  deleteMedicine(String id);
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

  @override
  deleteMedicine(String id) {
    try {
      medicinedata.removeWhere((element) => element.id == id);
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("medicines")
          .doc(id)
          .delete()
          .then((value) => print("deleted successfully"));
      update();
      Get.back();
    } on Exception catch (e) {
      print("شوف ايش الدعوة  $e");
    }
  }
}
