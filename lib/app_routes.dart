import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tafatun/view/ai/ai_settings.dart';
import 'package:tafatun/view/auth/auth_page.dart';
import 'package:tafatun/view/auth/login.dart';
import 'package:tafatun/view/auth/welcome_page.dart';
import 'package:tafatun/view/home/emergency/add_emergency_form.dart';
import 'package:tafatun/view/home/add_medicine/add_medicine.dart';
import 'package:tafatun/view/home/emergency/emergency.dart';
import 'package:tafatun/view/home/medicineAbinet/details_medicine.dart';
import 'package:tafatun/view/home/medicineAbinet/expired_medicines.dart';
import 'package:tafatun/view/home/medicineAbinet/medicine_abinet.dart';
import 'package:tafatun/view/home/newUser/new_user.dart';
import 'package:tafatun/view/navigationBar/navBar.dart';

import 'view/auth/singup.dart';
import 'view/home/notif_users/notifusers.dart';

abstract class AppRoutes {
  // this is the routes name
  static const String kAuth = '/';
  static const String kWelcomePage = '/welcome';
  static const String kLogin = '/login';
  static const String kSignup = '/signup';
  static const String kAddMedicine = '/addMedicine';
  static const String kNavbar = '/navbar';
  static const String kAiSettings = '/aiSettings';
  static const String kMedicineAbinet = '/MedicineAbinet';
  static const String kExpiredMedicines = '/ExpiredMedicines';
  static const String kNewUser = '/NewUser';
  static const String kEmergency = '/Emergency';
  static const String kAddEmergencyForm = '/AddEmergencyForm';
  static const String kDetailsMedicine = '/DetailsMedicine';
  static const String knotifusers = '/Notifusers';

  // this is the routes list
  static List<GetPage<dynamic>> getPages = [
    GetPage(name: kWelcomePage, page: () => const WelcomePage()),
    GetPage(name: kSignup, page: () => const Singup()),
    GetPage(name: kLogin, page: () => const Login()),
    GetPage(
      name: kAuth, page: () => const AuthPage(), //const Test(),
    ),
    GetPage(name: kAddMedicine, page: () => const AddMedicine()),
    GetPage(name: kNavbar, page: () => const NavBar()),
    GetPage(name: kAiSettings, page: () => const AiSettings()),
    GetPage(name: kMedicineAbinet, page: () => const MedicineAbinet()),
    GetPage(name: kExpiredMedicines, page: () => const ExpiredMedicines()),
    GetPage(name: kNewUser, page: () => const NewUser()),
    GetPage(name: kEmergency, page: () => const Emergency()),
    GetPage(name: kAddEmergencyForm, page: () => const AddEmergencyForm()),
    GetPage(name: kDetailsMedicine, page: () => DetailsMedicine()),
    GetPage(name: knotifusers, page: () => const Notifusers()),
  ];
}
