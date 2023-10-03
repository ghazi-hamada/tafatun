import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.title,
    required this.ontap,
  });
  final String title;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(59, 0, 48, 0),
        width: 190,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff89d2c9)),
          color: const Color(0xff89d2c9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0, 4),
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff000000),
                fontSize: 20,
                fontFamily: 'Kosugi',
                fontWeight: FontWeight.w600,
              )),
        ),
      ),
    );
  }
}
