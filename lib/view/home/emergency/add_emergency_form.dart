import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/controller/addEmergency_controller.dart';
import 'package:tafatun/core/validinput.dart';
import 'package:tafatun/view/auth/widgets/form_field_widget.dart';
import 'package:tafatun/view/widgets/custom_button_form.dart';

class AddEmergencyForm extends StatelessWidget {
  const AddEmergencyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddEmergencyControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xffE7F6F3),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 5),
                borderRadius: BorderRadius.circular(100)),
            child:
                const Icon(Icons.person_sharp, size: 90, color: Colors.black),
          ),
          const Text("إضافة جهة اتصال ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: GetBuilder<AddEmergencyControllerImp>(
                builder: (controller) => Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormFieldWidget(
                        controller: controller.nameController,
                        title: "الأسم",
                        valid: (p0) {
                          return validinput(p0!, 3, 25, 'name');
                        },
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 10),
                      FormFieldWidget(
                        controller: controller.emailController,
                        title: "الإيميل",
                        valid: (p0) {
                          return validinput(p0!, 3, 25, 'email');
                        },
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 10),
                      FormFieldWidget(
                        controller: controller.relationController,
                        title: "صلة القرابة",
                        valid: (p0) {
                          return validinput(p0!, 3, 25, 'relation');
                        },
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 30),
                      CustomButtonForm(
                          title: "إضافة",
                          onPressed: () {
                            controller.addEmergency(context);
                          })
                    ],
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
