import 'package:flutter/material.dart';

class CustomButtonForm extends StatelessWidget {
  const CustomButtonForm({
    super.key,
    required this.title,
    this.onPressed,
  });
  final String title;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: const Color(0xff89D2C9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      height: 50,
      minWidth: 150,
      onPressed: (onPressed),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
