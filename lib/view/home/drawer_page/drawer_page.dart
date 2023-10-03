import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/app_routes.dart';
import 'package:tafatun/controller/medical_controller.dart';
import 'package:tafatun/core/constant/color.dart';
import 'package:tafatun/core/constant/image_assets.dart';
import 'package:tafatun/main.dart';
import 'package:tafatun/model/children_model.dart';
import 'package:tafatun/services/servises.dart';
import 'package:tafatun/view/home/drawer_page/widget/button_drawer_widget.dart';
import 'package:tafatun/view/home/widgets/custom_widget_button_txt.dart';
import 'package:tafatun/view/home/widgets/line_home_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MedicalControllerImp());
    return Drawer(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset(
              ImageAssets.logo,
              height: 180,
              width: 200,
            ),
          ),
          const LineHomeWidget(),
          const SizedBox(
            height: 30,
          ),
          ButtonDrawerWidget(
              title: "إضافة إيميل للطوارئ",
              onTap: () {
                Get.toNamed(AppRoutes.kEmergency);
                print('object');
              },
              icon: Icons.add_call),
          ButtonDrawerWidget(
              title: "إضافة مستخدم جديد",
              onTap: () {
                Get.toNamed(AppRoutes.kNewUser);
              },
              icon: Icons.person_add_alt_1),
          ButtonDrawerWidget(
              title: "اشعارات المستخدمين",
              onTap: () {
                Get.toNamed(AppRoutes.knotifusers);
              },
              icon: Icons.notifications),
          const Spacer(),
          Column(
            children: [
              GetBuilder<MedicalControllerImp>(
                builder: (controller) => Column(
                  children: [
                    StreamBuilder(
                        stream: readChildrenModel(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final List<ChildrenModel> childrenModel =
                                snapshot.data as List<ChildrenModel>;
                            childrenModel.add(ChildrenModel(
                              name: "انا/${controller.nameController.text}",
                            ));
                            return SizedBox(
                              height: 150,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return CustomWidgetbuttontxt(
                                    delete: () async {
                                      if (index != childrenModel.length - 1) {
                                        //هل انت متاكد من حذف هذا الاسم
                                        Get.defaultDialog(
                                          title:
                                              "هل انت متاكد من حذف هذا الاسم",
                                          middleText:
                                              childrenModel[index].name!,
                                          titleStyle: TextStyle(
                                            color: AppColor.primaryColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                "لا",
                                                style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection("users")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .collection("children")
                                                    .doc(snapshot
                                                        .data![index].id)
                                                    .delete();
                                                Get.back();
                                              },
                                              child: Text(
                                                "نعم",
                                                style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                        // childrenModel.removeAt(index);
                                      }
                                    },
                                    id: index == childrenModel.length - 1
                                        ? null
                                        : snapshot.data![index].id,
                                    iconUser: index == childrenModel.length - 1
                                        ? null
                                        : Icons.delete,
                                    title: childrenModel[index].name!,
                                    onTap: () {
                                      MyServices myServices = Get.find();
                                      myServices.sharedPreferences.setString(
                                          "nameUser",
                                          childrenModel[index].name!);
                                      // تم اضافة هذا الاسم كمستخدم
                                      Get.defaultDialog(
                                        title: "تم اضافة هذا الاسم كمستخدم",
                                        middleText: childrenModel[index].name!,
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "حسنا",
                                              style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                        titleStyle: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ],
                ),
              ),
              Divider(
                color: AppColor.primaryColor,
                thickness: 2,
              ),
              CustomWidgetbuttontxt(
                  title: "تسجيل الخروج",
                  onTap: () async {
                    //هل انت متاكد من تسجيل الخروج
                    Get.defaultDialog(
                      title: "هل انت متاكد من تسجيل الخروج",
                      titleStyle: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      content: const Text("سيتم تسجيل الخروج من التطبيق ⚠️"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "لا",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Get.back();
                          },
                          child: Text(
                            "نعم",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                    // await FirebaseAuth.instance.signOut();
                  },
                  icon: Icons.logout),
            ],
          ),
        ],
      ),
    );
  }

  Stream<List<ChildrenModel>> readChildrenModel() => FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("children")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => ChildrenModel.fromJson(document.data()))
          .toList());
}
