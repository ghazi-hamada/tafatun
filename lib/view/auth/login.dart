import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tafatun/core/validinput.dart';
import 'package:tafatun/view/auth/widgets/back_grund_color.dart';
import 'package:tafatun/view/auth/widgets/button_widget.dart';
import 'package:tafatun/view/auth/widgets/form_field_widget.dart';
import 'package:tafatun/view/auth/widgets/line_widget.dart';

import '../../controller/auth/login_controller.dart';
import '../../core/constant/image_assets.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginControllerImp());
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
                      child: GetBuilder<LoginControllerImp>(
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
                                const SizedBox(height: 50),
                                const Text('قم بتسجل الدخول ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF969191))),
                                const LineWidget(),
                                const SizedBox(height: 45),
                                FormFieldWidget(
                                  title: 'البريد الإلكتروني',
                                  controller: controller.email,
                                  valid: (value) {
                                    return validinput(value!, 6, 50, 'email');
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                FormFieldWidget(
                                  obsText: T,
                                  title: 'كلمة السر',
                                  controller: controller.password,
                                  valid: (value) {
                                    return validinput(
                                        value!, 6, 50, 'password');
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                                const Text(
                                  ' نسيت كلمة المرور؟ ',
                                  style: TextStyle(
                                    color: Color(0xFF969191),
                                    fontSize: 13,
                                    fontFamily: 'Kosugi',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ButtonWidget(
                                  title: 'تسجيل الدخول',
                                  ontap: () {
                                    controller.login(context);
                                  },
                                )
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
