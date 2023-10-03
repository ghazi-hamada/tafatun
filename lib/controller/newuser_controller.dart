import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tafatun/core/constant/image_assets.dart';
import 'package:tafatun/main.dart';

abstract class NewUserController extends GetxController {
  newUser(BuildContext context);
}

class NewUserControllerImp extends NewUserController {
  late TextEditingController nameController;
  final formKey = GlobalKey<FormState>();
  List<String> images = [
    "${ImageAssets.images}/male 1.png",
    "${ImageAssets.images}/33409dd9-7f7f-4cf5-8602-e9039a10c8fc 1.png",
    "${ImageAssets.images}/image 3.png",
  ];
  @override
  newUser(BuildContext context) {
    if (formKey.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("children")
          .add(
        {
          'name': nameController.text,
        },
      ).then((value) => value.update({'id': value.id}));
      Get.back();
    }
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
