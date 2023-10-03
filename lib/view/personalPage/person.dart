import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/controller/medical_controller.dart';
import 'package:tafatun/core/constant/color.dart';
import 'package:tafatun/view/widgets/text_form_feild_addMid.dart';

class Person extends StatelessWidget {
  const Person({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MedicalControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xffDBE9E6),
      body: GetBuilder<MedicalControllerImp>(
        builder: (controller) => Column(
          children: [
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                "الملف الشخصي",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.primaryColor, width: 5),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(Icons.person_sharp,
                          size: 90,
                          color: AppColor.primaryColor.withOpacity(0.5)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: const Divider(
                        color: Color(0xffDDF2F0),
                        thickness: 2,
                        indent: 110,
                        endIndent: 110,
                      ),
                    ),
                    Column(children: [
                      TextFormFeildAddMid(
                        title: "الاسم :",
                        hintText: "",
                        isDate: false,
                        isEnable: true,
                        textEditingController: controller.nameController,
                      ),
                      const SizedBox(height: 20),
                      TextFormFeildAddMid(
                        title: "البريد الالكتروني :",
                        hintText: "",
                        isDate: false,
                        isEnable: true,
                        textEditingController: controller.emailController,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: const Color(0xff89D2C9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Icon(
                    Icons.logout,
                    color: AppColor.primaryColor,
                  ),
                  label: const Text("تسجيل الخروج",
                      style: TextStyle(
                          color: Color(0xffD06868),
                          fontWeight: FontWeight.w400))),
            )
          ],
        ),
      ),
    );
  }
}
