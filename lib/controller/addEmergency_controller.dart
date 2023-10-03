import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tafatun/main.dart';
import 'package:get/get.dart';

abstract class AddEmergencyController extends GetxController {
  addEmergency(BuildContext context);
}

class AddEmergencyControllerImp extends AddEmergencyController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController relationController;
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    relationController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    relationController.dispose();
    super.dispose();
  }

  @override
  addEmergency(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection("emergency")
          .add({
        'name': nameController.text,
        'email': emailController.text,
        'relation': relationController.text,
      }).then((value) => value.update({'id': value.id}));
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }
}
