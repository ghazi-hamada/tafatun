import 'package:flutter/material.dart';
import 'package:tafatun/core/constant/color.dart';

class LineHomeWidget extends StatelessWidget {
  const LineHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
          color: AppColor.secondaryColor,
          borderRadius: BorderRadius.circular(60),
        ));
  }
}
