import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tafatun/main.dart';
import 'package:tafatun/model/emergency_model.dart';

abstract class EmergencyController extends GetxController {
  getEmergency();
  deleteEmergency(String id);
}

class EmergencyControllerImp extends EmergencyController {
  List<EmergencyModel> emergencydata = [];
  CollectionReference emergency = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('emergency');
  @override
  getEmergency() async {
    var responsebody = await emergency.get();
    for (var element in responsebody.docs) {
      emergencydata
          .add(EmergencyModel.fromJson(element.data() as Map<String, dynamic>));

      update();
    }
  }

  @override
  void onInit() async {
    getEmergency();
    super.onInit();
  }

  @override
  deleteEmergency(String id) async {
    FirebaseFirestore.instance.collection('emergency').doc(id).delete();
    emergencydata.removeWhere((element) => element.id == id);
    update();
  }
}
