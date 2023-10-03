import 'package:flutter/material.dart';
import 'package:tafatun/core/constant/color.dart';

class ButtonDrawerWidget extends StatelessWidget {
  const ButtonDrawerWidget({
    Key? key,
    required this.title,
    this.onTap,
    this.icon,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColor.secondaryColor, width: 3),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF98E7DD),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        horizontalTitleGap: 0,
        leading: Icon(
          icon,
          color: const Color(0xff25766C),
          size: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
