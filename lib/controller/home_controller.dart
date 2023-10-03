import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tafatun/helper/pdf_invoice_helper.dart';
import 'package:get/get.dart';
import 'package:tafatun/core/Methods/timestamptotime.dart';
import 'package:tafatun/main.dart';
import 'package:tafatun/model/audio_modell.dart';
import 'package:tafatun/model/medicine_model.dart';

import '../services/servises.dart';

abstract class HomeController extends GetxController {
  getData();
}

class HomeControllerImp extends HomeController {
  late AudioPlayer audioPlayer;
  List<MedicineModel> medicinedata = [];
  List<AudioModell> audioData = [];
  MyServices myServices = Get.find();
  bool ispaly = false;
  Query<Map<String, dynamic>> medicine = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("medicines");
  Query<Map<String, dynamic>> audio = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("audio");
  @override
  getData() async {
    medicinedata.clear();
    var responsebody = await medicine.get();

    for (var element in responsebody.docs) {
      Timestamp? dateend = MedicineModel.fromJson(element.data()).dateend;
      if (!isDateBeforeNow(dateend!)) {
        medicinedata.add(MedicineModel.fromJson(element.data()));
        medicinedata.sort((b, a) => a.takeMedicine == b.takeMedicine
            ? 0
            : a.takeMedicine!
                ? -1
                : 1);
      }
      Timestamp? stopdate = MedicineModel.fromJson(element.data()).stopdate;
      if (!isDateBeforeNow(stopdate!)) {
        AwesomeNotifications().cancel(element.id.hashCode);
      }
      update();
    }
  }

  getAudio() async {
    var responsebody = await audio.get();
    audioData.clear();
    for (var element in responsebody.docs) {
      audioData.add(AudioModell.fromJson(element.data()));
    }
    update();
    print(audioData.length);
  }

  

  @override
  void onInit() async {
    audioPlayer = AudioPlayer();
    await getAudio();
    await getData();
    PdfInvoicePdfHelper.init();
    super.onInit();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playRecording1(String audioPath) async {
    try {
      if (!ispaly) {
        ispaly = true;
        update();
        await audioPlayer.play(UrlSource(audioPath));
      } else {
        ispaly = false;
        await audioPlayer.stop();
        update();
      }
    } catch (e) {
      print("Error play recording: ${e.toString()}");
    }
    update();
  }
}
