import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tafatun/core/constant/image_assets.dart';
import 'package:tafatun/view/auth/widgets/back_grund_color.dart';
import 'package:tafatun/view/auth/widgets/button_widget.dart';
import 'package:tafatun/view/auth/widgets/form_field_widget.dart';
import 'package:tafatun/view/auth/widgets/line_widget.dart';

import '../../controller/auth/singup_controller.dart';
import '../../core/validinput.dart';

class Singup extends StatelessWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SignupControllerImp());

    return Scaffold(
        body: BackGraundColor(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 20 / 2),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      margin: const EdgeInsets.only(top: 130.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: GetBuilder<SignupControllerImp>(
                        builder: (controller) => Form(
                          key: controller.formstate,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Image.asset(
                                  ImageAssets.logo,
                                  fit: BoxFit.cover,
                                  height: 166,
                                  width: 226,
                                ),
                                const SizedBox(height: 30),
                                const Text("إنشاء حساب جديد",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF969191))),
                                const LineWidget(),
                                const SizedBox(height: 35),
                                FormFieldWidget(
                                  title: 'الاسم',
                                  controller: controller.nameController,
                                  valid: (value) {
                                    return validinput(
                                        value!, 6, 50, 'username');
                                  },
                                  keyboardType: TextInputType.name,
                                ),
                                FormFieldWidget(
                                  title: 'رقم الجوال',
                                  controller: controller.phoneController,
                                  valid: (value) {
                                    return validinput(value!, 6, 50, 'phone');
                                  },
                                  keyboardType: TextInputType.phone,
                                ),
                                FormFieldWidget(
                                  title: 'البريد الإلكتروني',
                                  controller: controller.emailController,
                                  valid: (value) {
                                    return validinput(value!, 6, 50, 'email');
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                FormFieldWidget(
                                  obsText: T,
                                  title: 'كلمة السر',
                                  controller: controller.passwordController,
                                  valid: (value) {
                                    return validinput(
                                        value!, 6, 50, 'password');
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                                FormFieldWidget(
                                  obsText: T,
                                  title: 'تاكيد كلمة السر',
                                  controller:
                                      controller.passwordConfirmController,
                                  valid: (value) {
                                    return validinput(
                                        value!, 6, 50, 'password');
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                                const SizedBox(height: 10),
                                ButtonWidget(
                                  title: 'إنشاء حساب',
                                  ontap: () {
                                    controller.singup(context);
                                  },
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
