import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tafatun/controller/ai_controller.dart';
import 'package:tafatun/core/constant/image_assets.dart';
import 'package:tafatun/main.dart';
import 'package:get/get.dart';
import 'package:tafatun/app_routes.dart';
import 'package:tafatun/view/ai/page_record.dart';

class Ai extends StatelessWidget {
  const Ai({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AiControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xffE7F6F3),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, right: 5),
              child: IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.kAiSettings);
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  )),
            ),
            Center(
              child: Container(
                child: const Text(
                  "التسجيلات الصوتية",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(
              endIndent: 110,
              indent: 110,
              color: Color.fromARGB(255, 186, 250, 239),
              thickness: 2,
            ),
            GetBuilder<AiControllerImp>(
              builder: (controller) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                width: 190,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border:
                        Border.all(color: const Color(0xffC9E9E2), width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xff9CE9DE),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ]),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const PageRecord());
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xff6DC1CF),
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            size: 40,
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        const Text("اضافة تسجيل\n صوتي",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ]),
                ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(uid)
                    .collection('audio')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: const Color(0xffC9E9E2), width: 2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xff9CE9DE),
                                  spreadRadius: 0,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ]),
                          child: Row(
                            children: [
                              Text(snapshot.data!.docs[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  controller.playRecording1(
                                      snapshot.data!.docs[index]['audio']);
                                },
                                child: Image.asset(
                                  "${ImageAssets.images}/au.png",
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
