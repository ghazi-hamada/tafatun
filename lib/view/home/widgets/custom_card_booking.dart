import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tafatun/controller/addMedicine_controller.dart';
import 'package:tafatun/controller/home_controller.dart';
import 'package:tafatun/main.dart';
import 'package:get/get.dart';

import 'package:tafatun/model/medicine_date.dart';
import 'package:tafatun/model/medicine_model.dart';
import 'package:tafatun/services/servises.dart';

class CustomCardBooking extends GetView<HomeControllerImp> {
  final MedicineModel? medicineModel;
  final bool? isnodata;
  const CustomCardBooking({
    Key? key,
    this.medicineModel,
    this.isnodata = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    log(myServices.sharedPreferences
        .getString("Medicine${medicineModel!.id}")
        .toString());
    MedicineDate mDate = MedicineDate.fromJson(jsonDecode(myServices
            .sharedPreferences
            .getString("Medicine${medicineModel!.id}")
            .toString()) ??
        {
          "medicineId": "1",
          "date": "2021-09-01 00:00:00.000",
        });
    DateTime medicineDate = DateTime.parse(mDate.date);
    DateTime nowDate = DateTime.now();

    final Duration duration = medicineDate.difference(nowDate);

    log("Date in shared preference is: $medicineDate");
    log("Id medicine is ${medicineModel!.id}, And date i: ${duration.inDays}, ${duration.inHours}, ${duration.inMinutes}");
    Get.put(HomeControllerImp());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 267,
      decoration: const BoxDecoration(
        color: Color(0xff89D2C9),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 20),
              height: 100,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: !isnodata!
                  ? Image.asset(
                      "assets/images/type/${medicineModel!.typeMedicine}.png",
                      fit: BoxFit.none,
                    )
                  : null),
          !isnodata!
              ? Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 60, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                "${duration.inMinutes < 0 ? 0 : duration.inMinutes} دقيقة",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.schedule,
                                color: Colors.black, size: 30)
                          ],
                        ),
                      ),
                      Text(
                        "${medicineModel!.nameMedicine}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${medicineModel!.doseMedicine}",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: 160,
                        height: 1,
                        color: Colors.white,
                      ),
                      GetBuilder<HomeControllerImp>(
                        builder: (controller) => !medicineModel!
                                    .takeMedicine! ||
                                duration.inMinutes < 0
                            ? Row(
                                children: [
                                  CustomButton(
                                    title: 'اخذته',
                                    onTap: () async {
                                      print("=======================");
                                      //update takeMedicine to true
                                      showDialog(
                                        context: context,
                                        builder: (context) => const Center(
                                            child: CircularProgressIndicator()),
                                      );
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(uid)
                                          .collection("medicines")
                                          .doc(medicineModel!.id)
                                          .update({
                                        "takeMedicine": true,
                                        "datereminder":
                                            //add 1 day to date
                                            Timestamp.fromDate(DateTime.now()
                                                .add(Duration(
                                                    hours: medicineModel!
                                                        .repetition!))),
                                      });

                                      print(medicineModel!.takeMedicine);
                                      MedicineDate mDate = MedicineDate(
                                        medicineId:
                                            "${medicineModel!.id.toString()}}",
                                        date: DateTime.now()
                                            .add(Duration(
                                                hours:
                                                    medicineModel!.repetition!))
                                            .toString(),
                                      );
                                      MyServices myServices = Get.find();

                                      myServices.sharedPreferences.setString(
                                        "Medicine${medicineModel!.id}",
                                        jsonEncode(mDate.toJson()),
                                      );

                                      navigatorKey.currentState!
                                          .popUntil((route) => route.isFirst);
                                      controller.getData();
                                      setSchedule(
                                          id: medicineModel!.id.hashCode,
                                          title: "تذكير الدواء",
                                          body:
                                              "حان وقت تناول الدواء ${medicineModel!.doseMedicine} بجرعة ${medicineModel!.nameMedicine} الخاص ب${myServices.sharedPreferences.getString('nameUser')}",
                                          hours: medicineModel!.repetition!);
                                      controller.update();
                                    },
                                    icon: Icons.check,
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  CustomButton(
                                    title: 'تخطي',
                                    onTap: () {
                                      log(medicineModel!.id.hashCode
                                          .toString());
                                      log((697944146).hashCode.toString());
                                    },
                                    icon: Icons.close,
                                  ),
                                ],
                              )
                            : const Text(
                                "تم اخذ الدواء ✅",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      )
                    ],
                  ),
                )
              : const Text(
                  "لا يوجد ادوية لهذا اليوم",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });
  final String title;
  final void Function() onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          Icon(icon, color: Colors.black, size: 20)
        ],
      ),
    );
  }
}
