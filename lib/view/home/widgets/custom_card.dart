import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String imageUrl;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF98E7DD),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        width: 170,
        height: 120,
        child: Column(children: [
          Image.asset(
            imageUrl,
            width: 69,
            height: 82,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(height: 1, fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
