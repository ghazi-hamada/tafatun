import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/app_routes.dart';
import 'package:tafatun/view/navigationBar/custom_button_navbar.dart';

import '../../controller/navbar_controller.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(NavBarControllerImp());
    return GetBuilder<NavBarControllerImp>(
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xffCEEDE7),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.kAddMedicine);
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
        bottomNavigationBar: const CustomButtonNavbar(),
        body: controller.data['page'][controller.currentIndex],
      ),
    );
  }
}
