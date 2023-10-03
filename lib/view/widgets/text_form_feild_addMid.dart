import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:tafatun/controller/addMedicine_controller.dart';
import 'package:tafatun/core/constant/color.dart';

class TextFormFeildAddMid extends GetView<AddMedicineControllerImp> {
  final String title;
  final String hintText;
  final TextEditingController? textEditingController;
  final Icon? icon;
  final String? Function(String?)? valid;
  final bool isDate;
  final bool isEnable;
  final void Function()? onTap;
  final int? pickerIndex;

  const TextFormFeildAddMid({
    super.key,
    required this.title,
    required this.hintText,
    this.textEditingController,
    this.icon,
    this.valid,
    required this.isDate,
    this.isEnable = false,
    this.onTap,
    this.pickerIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3f000000),
                      offset: Offset(0, 4),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: TextFormField(
                  enabled: isEnable ? false : true,
                  validator: valid,
                  controller: textEditingController,
                  readOnly: isDate,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFBFFFE),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: AppColor.primaryColor, width: 1),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: AppColor.primaryColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: AppColor.primaryColor, width: 1),
                      ),
                      suffixIcon: icon,
                      hintText: hintText),
                  onTap: onTap,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
