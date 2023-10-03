import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/app_routes.dart';
import 'package:tafatun/model/medicine_model.dart';

class CardWidgetMedicineCabinet extends StatelessWidget {
  final MedicineModel medicineModel;
  final bool isExpired;
  const CardWidgetMedicineCabinet({
    super.key,
    required this.medicineModel,
    this.isExpired = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.kDetailsMedicine, arguments: {
          "medicineModel": medicineModel,
          "isExpired": isExpired,
        });
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        height: 92,
        width: 166,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 7,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  medicineModel.nameMedicine!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Hero(
                  tag: medicineModel.id!,
                  child: Image.asset(
                      "assets/images/type/${medicineModel.typeMedicine}.png",
                      height: 50,
                      width: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
