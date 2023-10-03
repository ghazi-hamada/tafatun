import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/controller/ai_controller.dart';
import 'package:tafatun/core/constant/image_assets.dart';
import 'package:tafatun/view/widgets/custom_button_form.dart';

class AiSettings extends StatelessWidget {
  const AiSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AiControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xffE7F6F3),
      body: GetBuilder<AiControllerImp>(
        builder: (controller) => Column(
          children: [
            Image.asset("${ImageAssets.images}/aiPage.png"),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("اسمح لي بإرسال الاشعارات الصوتية",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          Switch(
                            value: controller.switchValue!,
                            onChanged: (value) {
                              controller.changeSwitch(value, 1);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("اسمح لي بالوصول الى المايكرفون",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          Switch(
                            value: controller.switchValue2!,
                            onChanged: (value) {
                              controller.changeSwitch(value, 2);
                            },
                          ),
                        ],
                      ),
                      CustomButtonForm(
                          title: "حفظ التغييرات", onPressed: () {}),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: 100,
                            color: const Color(0xff89D2C9),
                          ),
                          Image.asset("${ImageAssets.images}/au.png"),
                          Container(
                            height: 1,
                            width: 100,
                            color: const Color(0xff89D2C9),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
