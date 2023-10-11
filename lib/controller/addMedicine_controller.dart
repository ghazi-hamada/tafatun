import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tafatun/app_routes.dart';
import 'package:tafatun/controller/home_controller.dart';
import 'package:tafatun/main.dart';
import 'package:tafatun/model/medicine_model.dart';
import 'package:tafatun/services/servises.dart';

import '../model/medicine_date.dart';

abstract class AddMedicineController extends GetxController {
  datePicker(
      BuildContext context, TextEditingController controller, int pickerIndex);
  timePicker(BuildContext context, TextEditingController controller);
  addMedicine(BuildContext context);
  validator(String value);
  showPickerNumber(BuildContext context, TextEditingController controller);
  late TextEditingController startController;
  late TextEditingController stopController;
  late TextEditingController dateendController;
  late TextEditingController datereminderController;
  late TextEditingController nameMedicine;
  late TextEditingController nameMedicineShort;
  late TextEditingController doseMedicine;
  late TextEditingController typeMedicine;
  late TextEditingController repetitionController;
  bool onClick = false;
  DateTime? startdate;
  DateTime? stopdate;
  DateTime? enddate;
  TimeOfDay? time;
  Timestamp timestamp = Timestamp.now();
  String id = '';
  int choose = 10;
  int? repetition;
  final formKey = GlobalKey<FormState>();
  MyServices myServices = Get.find();
  late MedicineModel medicineModel;
}

class AddMedicineControllerImp extends AddMedicineController {
  Map data = {
    'title': [
      'حبة',
      'إبرة',
      'شراب سائل',
      'قطرة',
    ],
    'icon': [
      '1',
      '2',
      '3',
      '4',
    ],
  };

  @override
  datePicker(BuildContext context, TextEditingController controller,
      int pickerIndex) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
    if (picked != null) {
      switch (pickerIndex) {
        case 1:
          startdate = picked;
          print("Picker 1 date selected is $startdate");
          break;

        case 2:
          stopdate = picked;
          print("Picker 2 date selected is $stopdate");
          break;

        case 3:
          enddate = picked;
          print("Picker 3 date selected is $enddate");
          break;
      }
    }
  }

  @override
  addMedicine(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      formKey.currentState!.save();
      var firebaseJson = {
        'id': '',
        'nameMedicine': nameMedicine.text.trim(),
        'nameMedicineShort': nameMedicineShort.text.trim(),
        'doseMedicine': doseMedicine.text.trim(),
        'typeMedicine': typeMedicine.text.trim(),
        'startdate': Timestamp.fromDate(startdate!),
        'stopdate': Timestamp.fromDate(stopdate!),
        'dateend': Timestamp.fromDate(enddate!),
        'datereminder': Timestamp.fromDate(timeOfDayToDateTime(time!)),
        'repetition': repetition,
        'takeMedicine': false,
      };
      if (Get.arguments != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('medicines')
            .doc(medicineModel.id)
            .update(firebaseJson);
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection("medicines")
            .add(firebaseJson)
            .then((value) {
          DateTime now = DateTime.now().add(Duration(hours: repetition!));
          String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
          MedicineDate mDate = MedicineDate(
            medicineId: value.id,
            date: formattedDate,
          );
          myServices.sharedPreferences
              .setString("Medicine${value.id}", jsonEncode(mDate.toJson()));

          value.update({'id': value.id});
          id = value.id;
          print("this hash code ${value.id.hashCode}");
          setSchedule(
              hours: repetition!,
              id: value.id.hashCode,
              title: "تذكير الدواء",
              body:
                  "حان وقت تناول الدواء ${doseMedicine.text.trim()} بجرعة ${nameMedicine.text.trim()} الخاص ب${myServices.sharedPreferences.getString('nameUser')}");
        });
      }
      HomeControllerImp homeControllerImp = Get.find();
      homeControllerImp.getData();

      Get.offNamed(AppRoutes.kNavbar);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      medicineModel = Get.arguments['medicineModel'];
    }

    startController = TextEditingController();
    stopController = TextEditingController();
    dateendController = TextEditingController();
    datereminderController = TextEditingController();
    nameMedicine = TextEditingController();
    nameMedicineShort = TextEditingController();
    doseMedicine = TextEditingController();
    typeMedicine = TextEditingController();
    repetitionController = TextEditingController();

    if (Get.arguments != null) {
      nameMedicine.text = medicineModel.nameMedicine!;
      nameMedicineShort.text = medicineModel.nameMedicineShort!;
      doseMedicine.text = medicineModel.doseMedicine!;
      repetitionController.text = medicineModel.repetition.toString();
    }

    super.onInit();
  }

  @override
  void dispose() {
    startController.dispose();
    stopController.dispose();
    dateendController.dispose();
    datereminderController.dispose();
    nameMedicine.dispose();
    nameMedicineShort.dispose();
    doseMedicine.dispose();
    typeMedicine.dispose();
    repetitionController.dispose();
    super.dispose();
  }

  @override
  validator(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 3) {
      return 'This field must be at least 3 characters';
    }
    return null;
  }

  @override
  timePicker(BuildContext context, TextEditingController controller) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      controller.text = value!.format(context).toString();
      time = value;
    });
  }

  DateTime timeOfDayToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  @override
  showPickerNumber(BuildContext context, TextEditingController controller) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 250,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    itemExtent: 32,
                    onSelectedItemChanged: (index) {
                      switch (index) {
                        case 0:
                          repetition = 0;
                          break;
                        case 1:
                          repetition = 6;
                          break;
                        case 2:
                          repetition = 8;
                          break;
                        case 3:
                          repetition = 12;
                          break;
                        case 4:
                          repetition = 24;
                          break;
                      }
                      print(repetition);
                      repetitionController.text =
                          "كل ${repetition.toString()} ساعات مره";
                    },
                    children: const [
                      Text("اختر الوقت"),
                      Text('6'),
                      Text('8'),
                      Text('12'),
                      Text('24'),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Duration timeToDuration(DateTime time) {
    final now = DateTime.now();
    return Duration(
      days: time.day - now.day,
      hours: time.hour - now.hour,
      minutes: time.minute - now.minute,
      seconds: time.second - now.second,
    );
  }

  int durationToMinutes(Duration duration) {
    return duration.inMinutes;
  }
}

void setSchedule({
  required int id,
  required String title,
  required String body,
  required int hours,
}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id,
      channelKey: 'schedule_channel',
      title: title,
      body: body,
    ),
    schedule: NotificationCalendar(
      repeats: true,
      hour: 0,
      minute: hours,
      second: 0,
    ),
  );
}
