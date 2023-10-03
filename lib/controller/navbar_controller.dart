import 'package:get/get.dart';
import 'package:tafatun/view/ai/ai.dart';
import 'package:tafatun/view/home/home.dart';
import 'package:tafatun/view/medicalRecord/medical.dart';
import 'package:tafatun/view/personalPage/person.dart';

abstract class NavBarController extends GetxController {
  changePage(int index);
}

class NavBarControllerImp extends NavBarController {
  int currentIndex = 3;
  Map data = {
    'icons': [
      "assets/images/p.png",
      "assets/images/ai.png",
      "assets/images/medical.png",
      "assets/images/home.png",
    ],
    
    'page': [
      const Person(),
      const Ai(),
      const Medical(),
      const Home(),
    ],
  };

  @override
  changePage(int index) {
    currentIndex = index;
    update();
  }
}
