  import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appbarWidget() {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ))
      ],
    );
  }
