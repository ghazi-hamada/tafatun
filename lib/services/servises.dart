import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    sharedPreferences = await SharedPreferences.getInstance();
AwesomeNotifications().initialize(
  // set the icon to a valid resource name
  'resource://drawable/active',
  [
    NotificationChannel(
      channelKey: 'basic_channel',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      importance: NotificationImportance.High,
    )
  ],
);


    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}


 