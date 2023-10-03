import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/controller/addMedicine_controller.dart';
import 'package:tafatun/view/home/widgets/appbar_widget.dart';
import 'package:tafatun/view/widgets/text_form_feild_addMid.dart';
import 'package:tafatun/view/home/widgets/type_medical.dart';

class AddMedicine extends StatelessWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddMedicineControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xffE7F6F3),
      appBar: appbarWidget(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.centerRight,
          child: GetBuilder<AddMedicineControllerImp>(
            builder: (controller) => Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "إضافة دواء جديد",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    endIndent: 110,
                    indent: 110,
                    color: Color.fromARGB(255, 186, 250, 239),
                    thickness: 2,
                  ),
                  TextFormFeildAddMid(
                    title: 'إسم الدواء:',
                    hintText: 'مثال: Midodrine',
                    textEditingController: controller.nameMedicine,
                    valid: (p0) => controller.validator(p0!),
                    isDate: false,
                  ),
                  TextFormFeildAddMid(
                    title: 'إسم الدواء المختصر:',
                    hintText: 'مثال: دواء الضغط',
                    textEditingController: controller.nameMedicineShort,
                    valid: (p0) => controller.validator(p0!),
                    isDate: false,
                  ),
                  TextFormFeildAddMid(
                    title: 'جرعة الدواء:',
                    hintText: 'مثال: 2 مغ',
                    textEditingController: controller.doseMedicine,
                    valid: (p0) => controller.validator(p0!),
                    isDate: false,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      'نوع الدواء:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  TypeMedical(),
                  TextFormFeildAddMid(
                    title: "تاريخ تذكير بالدواء:",
                    hintText: "مثال:من 17/10 الاحد ",
                    textEditingController: controller.startController,
                    icon: const Icon(Icons.calendar_month_outlined),
                    valid: (p0) => controller.validator(p0!),
                    isDate: true,
                    pickerIndex: 1,
                    onTap: () => controller.datePicker(
                        context, controller.startController, 1),
                  ),
                  TextFormFeildAddMid(
                    title: "تاريخ انتهاء تذكير بالدواء:",
                    hintText: "مثال:من 24/10 الاحد",
                    textEditingController: controller.stopController,
                    icon: const Icon(Icons.calendar_month_outlined),
                    valid: (p0) => controller.validator(p0!),
                    isDate: true,
                    pickerIndex: 1,
                    onTap: () => controller.datePicker(
                        context, controller.stopController, 2),
                  ),
                  TextFormFeildAddMid(
                    title: "وقت البدء للتذكير بالدواء:",
                    hintText: "مثال:  10:00م /كل يومين",
                    textEditingController: controller.datereminderController,
                    icon: const Icon(Icons.schedule_outlined),
                    valid: (p0) => controller.validator(p0!),
                    isDate: true,
                    onTap: () {
                      controller.timePicker(
                          context, controller.datereminderController);
                    },
                  ),
                  //How many repetitions per day ?
                  TextFormFeildAddMid(
                    title: "عدد مرات تكرار الدواء في اليوم:",
                    hintText: "مثال: 3 مرات",
                    textEditingController: controller.repetitionController,
                    icon: const Icon(Icons.repeat_outlined),
                    valid: (p0) => controller.validator(p0!),
                    onTap: () {
                      controller.showPickerNumber(
                          context, controller.repetitionController);
                    },
                    isDate: true,
                  ),
                  TextFormFeildAddMid(
                    title: " تاريخ انتهاء صلاحية الدواء:",
                    hintText: "مثال:27-10-2022 ميلادي",
                    textEditingController: controller.dateendController,
                    icon: const Icon(Icons.calendar_month_outlined),
                    valid: (p0) => controller.validator(p0!),
                    isDate: true,
                    pickerIndex: 3,
                    onTap: () => controller.datePicker(
                        context, controller.dateendController, 3),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: MaterialButton(
                        color: const Color(0xff89D2C9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        textColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        onPressed: () {
                          controller.addMedicine(context);
                        },
                        child: const Text('إضافة الدواء',
                            style: TextStyle(fontSize: 14))),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
