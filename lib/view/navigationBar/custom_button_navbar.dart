import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/controller/navbar_controller.dart';

class CustomButtonNavbar extends GetView<NavBarControllerImp> {
  const CustomButtonNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: BottomAppBar(
        shadowColor: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          children: [
            ...List.generate(controller.data['icons'].length + 1, (index) {
              int i = index > 2 ? index - 1 : index;
              return index == 2
                  ? const Spacer()
                  : InkWell(
                      onTap: () => controller.changePage(i),
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Image.asset(controller.data['icons'][i])),
                    );
            })
          ],
        ),
      ),
    );
  }
}
// 6DC1CF