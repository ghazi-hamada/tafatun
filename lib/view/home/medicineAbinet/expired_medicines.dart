import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/controller/expiredmedicines_controller.dart';
import 'package:tafatun/view/home/widgets/appbar_widget.dart';
import 'package:tafatun/view/home/widgets/card_widget_medicine_cabinet.dart';
import 'package:tafatun/view/home/widgets/line_home_widget.dart';

class ExpiredMedicines extends StatelessWidget {
  const ExpiredMedicines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ExpiredMedicinesControllerImp>(
        () => ExpiredMedicinesControllerImp());

    return Scaffold(
        appBar: appbarWidget(),
        backgroundColor: const Color(0xffDBE9E6),
        body: GetBuilder<ExpiredMedicinesControllerImp>(
          builder: (controller) => Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "خزانة الأدوية المنتهية\n الصلاحية",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, height: 1 / 1.2),
                textAlign: TextAlign.center,
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 0, bottom: 20, right: 100, left: 100),
                  child: const LineHomeWidget()),
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 9 / 7,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: controller.medicinedata.length,
                    itemBuilder: (context, index) =>
                        GetBuilder<ExpiredMedicinesControllerImp>(
                          builder: (controller) => CardWidgetMedicineCabinet(
                              medicineModel: controller.medicinedata[index],
                              isExpired: true),
                        )),
              )
            ],
          ),
        ));
  }
}
