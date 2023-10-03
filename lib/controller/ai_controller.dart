import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:tafatun/main.dart';
import 'package:get/get.dart';
import 'package:tafatun/services/servises.dart';
import '../model/audio_model.dart';

abstract class AiController extends GetxController {
  changeSwitch(bool val, int i);
  saveAudio();
  getData();
}

class AiControllerImp extends AiController {
  late Record audioRecorder;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  bool ispaly = false;
  String audioPath = "";
  MyServices myServices = Get.find();
  bool? switchValue;
  bool? switchValue2;
  List<AudioModel> audioData = [];
  List<AudioModel> itemslistMedicine = [];
  Query<Map<String, dynamic>> medicine = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("audio");
  late TextEditingController nameAudioController;
  @override
  void onInit() {
    audioRecorder = Record();
    audioPlayer = AudioPlayer();
    getData();
    switchValue = myServices.sharedPreferences.getBool("switchValue") ?? false;
    switchValue2 =
        myServices.sharedPreferences.getBool("switchValue2") ?? false;
    nameAudioController = TextEditingController();
    super.onInit();
  }

  @override
  changeSwitch(bool val, int i) {
    switch (i) {
      case 1:
        myServices.sharedPreferences.setBool("switchValue", val);
        switchValue = val;
        break;
      case 2:
        myServices.sharedPreferences.setBool("switchValue2", val);
        switchValue2 = val;
        break;
    }
    update();
  }

  @override
  void dispose() {
    nameAudioController.dispose();
    audioRecorder.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    nameAudioController.dispose();
    super.onClose();
  }

  @override
  saveAudio() async {
    if (nameAudioController.text.isNotEmpty && audioPath.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("audio")
          .add({
        "id": '',
        "name": nameAudioController.text,
        "audio": audioPath,
      }).then((value) {
        value.update({"id": value.id});
        nameAudioController.clear();
        Get.back();
      });
      update();
    }
  }

  @override
  getData() async {
    var responsebody = await medicine.get();
    for (var element in responsebody.docs) {
      audioData.add(AudioModel.fromJson(element.data()));
      update();
    }
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start();

        isRecording = true;
        update();
      }
    } catch (e) {
      print("Error Starting recording: ${e.toString()}");
    }
    update();
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecorder.stop();

      isRecording = false;
      audioPath = path!;
      update();
    } catch (e) {
      print("Error stop recording: ${e.toString()}");
    }
    update();
  }

  Future<void> playRecording() async {
    try {
      if (!ispaly) {
        ispaly = true;
        update();
        await audioPlayer.play(UrlSource(audioPath));
      } else {
        ispaly = false;
        update();
        await audioPlayer.stop();
      }
    } catch (e) {
      print("Error play recording: ${e.toString()}");
    }
    update();
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
