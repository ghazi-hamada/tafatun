import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/controller/addMedicine_controller.dart';
import 'package:tafatun/core/constant/color.dart';

class TypeMedical extends GetView<AddMedicineControllerImp> {
  const TypeMedical({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(controller.data['icon'].length, (index) {
          return InkWell(
            onTap: () {
              controller.typeMedicine.text = controller.data['icon'][index];
              controller.onClick = !controller.onClick;
              controller.choose = index;
              print("${controller.data['icon'][index]}");
              controller.update();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: index == controller.choose
                          ? AppColor.primaryColor
                          : null,
                      borderRadius: BorderRadius.circular(40),
                      border:
                          Border.all(color: AppColor.primaryColor, width: 1),
                    ),
                    child: Image.asset(
                        'assets/images/type/${controller.data['icon'][index]}.png',
                        height: 30,
                        width: 30),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: index == controller.choose
                          ? Border(
                              bottom: BorderSide(color: AppColor.primaryColor))
                          : null,
                    ),
                    child: Text(
                      controller.data['title'][index],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          );
        })
      ],
    );
  }
}
