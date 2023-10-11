import 'package:tafatun/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tafatun/controller/medical_controller.dart';
import 'package:tafatun/core/constant/color.dart';
import 'package:tafatun/helper/pdf_helper.dart';
import 'package:tafatun/helper/pdf_invoice_helper.dart';
import 'package:tafatun/view/home/widgets/line_home_widget.dart';
import 'package:tafatun/view/medicalRecord/widget/custom_button_medical.dart';
import 'package:tafatun/view/widgets/text_form_feild_addMid.dart';

class Medical extends StatelessWidget {
  const Medical({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerImp homeControllerImp = Get.put(HomeControllerImp());
    Get.lazyPut(() => MedicalControllerImp());
    return GetBuilder<MedicalControllerImp>(
      builder: (controller) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: const Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'مشاركة السجل الطبي ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LineHomeWidget()
                ],
              ),
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.primaryColor, width: 5),
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(Icons.person_sharp,
                  size: 90, color: AppColor.primaryColor.withOpacity(0.5)),
            ),
            const SizedBox(height: 20),
            TextFormFeildAddMid(
              title: "الاسم :",
              hintText: "email",
              isDate: false,
              isEnable: true,
              textEditingController: controller.nameController,
            ),
            const SizedBox(height: 90),
            CustomButtonMedical(
              title: "إصدار سجل طبي",
              onTap: () async {
                final pdfFile = await PdfInvoicePdfHelper.generate(
                    homeControllerImp.medicinedata);

                await PdfHelper.openFile(pdfFile)
                    ;
              },
            ),
          ],
        ),
      ),
    );
  }
}
