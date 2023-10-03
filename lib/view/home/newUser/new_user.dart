import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/controller/newuser_controller.dart';
import 'package:tafatun/core/constant/image_assets.dart';
import 'package:tafatun/core/validinput.dart';
import 'package:tafatun/view/auth/widgets/form_field_widget.dart';
import 'package:tafatun/view/widgets/custom_button_form.dart';

class NewUser extends StatelessWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewUserControllerImp controller = Get.put(NewUserControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xffCEEDE7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(ImageAssets.logo),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'إضافة مستخدم جديد',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  controller.images.length,
                  (index) => Image.asset(
                    controller.images[index],
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: controller.formKey,
              child: FormFieldWidget(
                controller: controller.nameController,
                title: "اسم المستخدم",
                valid: (p0) {
                  return validinput(p0!, 3, 25, 'name');
                },
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtonForm(
                  title: "اضافة مستخدم",
                  onPressed: () {
                    controller.newUser(context);
                  },
                ),
                CustomButtonForm(
                  title: "إلغاء",
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
