import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/controller/medicineAbinet_controller.dart';
import 'package:tafatun/view/home/widgets/appbar_widget.dart';
import 'package:tafatun/view/home/widgets/card_widget_medicine_cabinet.dart';
import 'package:tafatun/view/home/widgets/custom_serch.dart';
import 'package:tafatun/view/home/widgets/line_home_widget.dart';

class MedicineAbinet extends StatelessWidget {
  const MedicineAbinet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<MedicineAbinetControllerImp>(
        () => MedicineAbinetControllerImp());
    return Scaffold(
      appBar: appbarWidget(),
      backgroundColor: const Color(0xffDBE9E6),
      body: GetBuilder<MedicineAbinetControllerImp>(
        builder: (controller) => Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "خزانة الأدوية",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: 0, bottom: 20, right: 100, left: 100),
                child: const LineHomeWidget()),
            CustomSerch(
              hintText: "ابحث عن الدواء",
              icon: const Icon(Icons.search),
              textEditingController: controller.searchController,
              onChanged: (p0) {
                controller.serach(p0);
              },
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 7,
                  crossAxisSpacing: 5,
                ),
                itemCount: controller.searchController.text.isEmpty
                    ? controller.medicinedata.length
                    : controller.itemslistMedicine.length,
                itemBuilder: (context, index) => CardWidgetMedicineCabinet(
                  medicineModel: controller.searchController.text.isEmpty
                      ? controller.medicinedata[index]
                      : controller.itemslistMedicine[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
