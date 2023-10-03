import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/app_routes.dart';
import 'package:tafatun/view/auth/widgets/back_grund_color.dart';
import 'package:tafatun/view/auth/widgets/button_widget.dart';

import '../../core/constant/image_assets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGraundColor(
        padding: const EdgeInsets.fromLTRB(42, 210, 55, 208),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageAssets.logo,
              fit: BoxFit.cover,
            ),
            Expanded(child: Container()),
            ButtonWidget(
              title: "تسجيل الدخول",
              ontap: () {
                Get.toNamed(AppRoutes.kLogin);
              },
            ),
            const SizedBox(height: 10),
            ButtonWidget(
              title: "إنشاء حساب",
              ontap: () {
                print("object");
                Get.toNamed(AppRoutes.kSignup);
              },
            ),
          ],
        ),
      ),
    );
  }
}
