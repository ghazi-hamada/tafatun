import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tafatun/core/Methods/timestamptotime.dart';
import 'package:tafatun/model/medicine_model.dart';
import 'package:tafatun/view/navigationBar/navBar.dart';
import 'package:tafatun/view/home/widgets/appbar_widget.dart';
import 'package:tafatun/view/home/widgets/line_home_widget.dart';
import 'package:get/get.dart';

class DetailsMedicine extends StatelessWidget {
  DetailsMedicine({Key? key}) : super(key: key);
  final MedicineModel medicineModel = Get.arguments["medicineModel"];
  final bool isExpired = Get.arguments["isExpired"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(),
      backgroundColor: const Color(0xffDBE9E6),
      body: Stack(
        children: [
          Column(
            children: [
              const Center(
                  heightFactor: 2,
                  child: Text(
                    "معلومات الدواء",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: const EdgeInsets.only(
                      top: 0, bottom: 0, right: 100, left: 100),
                  child: const LineHomeWidget()),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xffFBFFFF),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: [
                          MedicineDetailsWidget(
                              title: "اسم الدواء",
                              child: Text(
                                "${medicineModel.nameMedicine}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              )),
                          MedicineDetailsWidget(
                            title: "نوع الدواء:",
                            child: Hero(
                              tag: medicineModel.typeMedicine!,
                              child: Image.asset(
                                  "assets/images/type/${medicineModel.typeMedicine}.png"),
                            ),
                          ),
                          MedicineDetailsWidget(
                            title: "الجرعة:",
                            child: Text(
                              medicineModel.doseMedicine!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          MedicineDetailsWidget(
                            title: "التكرار:",
                            child: Text(
                              //formatTimestampToDate(medicineModel.startdate!),
                              "كل ${medicineModel.repetition} ساعات مره",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          MedicineDetailsWidget(
                            title: "وقت التنبية:",
                            child: Text(
                              formatTimestampToTime(
                                  medicineModel.datereminder!),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          MedicineDetailsWidget(
                            title: "تاريخ انتهاء صلاحية الدواء:",
                            child: Text(
                              isExpired
                                  ? "انتهى صلاحية الدواء"
                                  : formatTimestampToDate(
                                      medicineModel.dateend!),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          //button delete medicine
                        ],
                      )),
                ),
              )
            ],
          ),
          isExpired
              ? Positioned(
                  bottom: 15,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonExpiredMedicines(
                        title: "استرجاع الدواء",
                        onPressed: () {
                          // deleteMedicine(medicineModel.id!);
                        },
                      ),
                      ButtonExpiredMedicines(
                        title: "حذف الدواء",
                        onPressed: () async {
                          //alert dialog to confirm delete medicine
                          showDialog(
                              //circular(10)
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("تأكيد الحذف"),
                                  content: const Text(
                                      "هل أنت متأكد من حذف هذا الدواء؟"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("لا")),
                                    TextButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection("medicine")
                                              .doc(medicineModel.id)
                                              .delete();
                                          Get.offAll(() => const NavBar());
                                        },
                                        child: const Text("نعم")),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

class ButtonExpiredMedicines extends StatelessWidget {
  const ButtonExpiredMedicines({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff89D2C9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}

class MedicineDetailsWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const MedicineDetailsWidget({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          child,
          const LineHomeWidget()
        ],
      ),
    );
  }
}
