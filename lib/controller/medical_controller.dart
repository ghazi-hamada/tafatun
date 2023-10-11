import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart';
import 'package:tafatun/helper/pdf_invoice_helper.dart';
import 'package:tafatun/main.dart';

abstract class MedicalController extends GetxController {
  getname();
}

class MedicalControllerImp extends MedicalController {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late String id;
  static late Font arfont;

  @override
  void onInit() async {
    getname();
    PdfInvoicePdfHelper.init();
    nameController = TextEditingController();
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  getname() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      nameController.text = value['name'];
      emailController.text = value['email'];
      id = value.id;
    });
    update();
  }
}
 