import 'package:flutter/material.dart';


class BackGraundColor extends StatelessWidget {
  const BackGraundColor({
    super.key, required this.child, this.padding, this.width,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
          colors: <Color>[
            Color(0xd0c8eae3),
            Color(0xffd6ebe7),
            Color(0xffffffff)
          ],
          stops: <double>[0, 0.5, 1],
        ),
      ),
      child: child
    );
  }
}
