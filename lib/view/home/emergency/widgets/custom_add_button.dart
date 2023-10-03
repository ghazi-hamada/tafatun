import 'package:flutter/material.dart';


class CustomAddButton extends StatelessWidget {
  const CustomAddButton({
    super.key,
    required this.onPressed,
    this.sizeicon,
  });
  final void Function() onPressed;
  final double? sizeicon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xff6DC1CF),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: IconButton(
        alignment: Alignment.center,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        iconSize: 45,
        icon: const Icon(Icons.add),
        onPressed: onPressed,
        color: Colors.white,
      ),
    );
  }
}
