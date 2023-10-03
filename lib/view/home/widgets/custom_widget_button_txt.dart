import 'package:flutter/material.dart';

import 'package:tafatun/core/constant/color.dart';

class CustomWidgetbuttontxt extends StatelessWidget {
  const CustomWidgetbuttontxt({
    Key? key,
    required this.title,
    this.index,
    required this.onTap,
    this.icon,
    this.iconUser,
    this.id,
    this.delete,
  }) : super(key: key);
  final String title;
  final int? index;
  final void Function() onTap;
  final IconData? icon;
  final IconData? iconUser;
  final String? id;
  final Function()? delete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: Icon(
        icon ?? Icons.person,
        color: AppColor.primaryColor,
      ),
      trailing: iconUser == null
          ? null
          : InkWell(
              onTap: delete,
              child: Icon(
                iconUser,
                color: AppColor.primaryColor,
              ),
            ),
      title: Text(
        title,
        style: TextStyle(
          color: icon == null ? Colors.black : const Color(0xffD06868),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
