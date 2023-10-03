import 'package:flutter/material.dart';
import 'package:tafatun/core/constant/color.dart';

class CustomSerch extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Widget icon;
  final void Function(String)? onChanged;

  const CustomSerch({
    super.key,
    required this.hintText,
    required this.icon,
    this.onChanged,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: textEditingController,
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFFBFFFE),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 1),
          ),
          suffixIcon: icon,
          hintText: hintText),
    );
  }
}