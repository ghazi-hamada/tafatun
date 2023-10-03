import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/app_routes.dart';
import 'package:tafatun/controller/emergency_controller.dart';
import 'package:tafatun/view/home/emergency/widgets/custom_add_button.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EmergencyControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xffE7F6F3),
      body: Column(children: [
        Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 180,
            width: 200,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: GetBuilder<EmergencyControllerImp>(
                      builder: (controller) => ListView.builder(
                        itemCount: controller.emergencydata.length,
                        itemBuilder: (context, index) {
                          return controller.emergencydata.isNotEmpty
                              ? Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          controller.emergencydata[index].name),
                                      subtitle: Text(
                                          "${controller.emergencydata[index].phone} - ${controller.emergencydata[index].relation}"),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          controller.deleteEmergency(controller
                                              .emergencydata[index].id);
                                        },
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                )
                              : const Text("no data");
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomAddButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.kAddEmergencyForm);
                    },
                  )
                ],
              )),
        )
      ]),
    );
  }
}
