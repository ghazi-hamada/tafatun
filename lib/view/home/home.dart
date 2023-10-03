import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/app_routes.dart';
import 'package:tafatun/controller/home_controller.dart';
import 'package:tafatun/core/Methods/timestamptotime.dart';

import 'package:tafatun/view/home/widgets/custom_card.dart';
import 'package:tafatun/view/home/widgets/custom_card_booking.dart';
import 'package:tafatun/view/home/drawer_page/drawer_page.dart';
import 'package:tafatun/view/home/widgets/line_home_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xffCEEDE7),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //image
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/co1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 10,
                  child: Builder(
                    builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const Icon(
                          Icons.list,
                          color: Colors.black,
                          size: 30,
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const LineHomeWidget(),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                CustomCard(
                  title: "خزانة الأدوية",
                  imageUrl: "assets/images/medicine.png",
                  onTap: () => Get.toNamed(AppRoutes.kMedicineAbinet),
                ),
                CustomCard(
                  title: "خزانة الأدوية المنتهية\n الصلاحية",
                  imageUrl: 'assets/images/expired.png',
                  onTap: () => Get.toNamed(AppRoutes.kExpiredMedicines),
                ),
              ],
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerRight,
              child: const Text(
                "أدوية اليوم",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GetBuilder<HomeControllerImp>(
              builder: (controller) => SizedBox(
                height: 160,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.medicinedata.length,
                  itemBuilder: (context, index) {
                    var bool = (isTimeBetweenTwoTimestamps(
                            startTime:
                                controller.medicinedata[index].startdate!,
                            endTime:
                                controller.medicinedata[index].stopdate!) &&
                        !isDateBeforeNow(
                            controller.medicinedata[index].dateend!));
                    if (bool) {
                      return CustomCardBooking(
                        medicineModel: controller.medicinedata[index],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
