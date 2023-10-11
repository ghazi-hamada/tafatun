import 'package:flutter/material.dart';
import 'package:tafatun/app_routes.dart';
import 'package:tafatun/services/servises.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tafatun/view/auth/widgets/utils.dart';

Future main() async {
  await initialServices();
  runApp(const MyApp());
}

var uid = FirebaseAuth.instance.currentUser!.uid;

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static const String title = 'tafatan';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Utils.messengerKey,
        title: title,
        theme: ThemeData(
            fontFamily: 'Noto_Sans_Arabic', primarySwatch: Colors.teal),
        locale: const Locale('ar'),
        getPages: AppRoutes.getPages,
      );
}

