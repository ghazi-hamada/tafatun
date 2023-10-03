import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tafatun/app_routes.dart';
import 'package:tafatun/view/auth/widgets/utils.dart';

import '../../main.dart';

abstract class SignupController extends GetxController {
  singup(BuildContext context);
  goTologin();
  showPassword();
}

class SignupControllerImp extends SignupController {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isShowPassword = true;
  @override
  goTologin() {
    Get.offNamed("/");
  }

  @override
  singup(BuildContext context) async {
    final isValid = formstate.currentState!.validate();
    
showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    if (isValid&&passwordController.text.trim()==passwordConfirmController.text.trim()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(e.message);
      }

      //add data
      addUserDetails(
        nameController.text.trim(),
        emailController.text.trim(),
        phoneController.text.trim()
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      Get.offAllNamed(AppRoutes.kAuth);
    }
  }

  Future addUserDetails(  String name, String email,  String phone) async {

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }
  
  @override
  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }
}
