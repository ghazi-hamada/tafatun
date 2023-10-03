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


    AwesomeNotifications().initialize('resource://drawable/active', [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        playSound: true,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'schedule_channel', 
        channelName: 'schedule notifications',
        channelDescription: 'Notification channel for basic tests',
        // soundSource: "resource://raw/sound.mp3",
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
        playSound: true,
        channelShowBadge: true,
      ),

    ]);
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}


 