import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tafatun/controller/ai_controller.dart';

class PageRecord extends GetView<AiControllerImp> {
  const PageRecord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AiControllerImp>();
    return Scaffold(
      backgroundColor: const Color(0xffE7F6F3),
      body: Column(children: [
        Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 180,
            width: 200,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: controller.nameAudioController,
                  decoration: const InputDecoration(
                    hintText: "اسم التسجيل",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GetBuilder<AiControllerImp>(
                  builder: (controller) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff6DC1CF),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                            onPressed: () {
                              if (controller.isRecording) {
                                controller.stopRecording();
                              } else {
                                controller.startRecording();
                              }
                            },
                            icon: Icon(
                              controller.isRecording ? Icons.stop : Icons.mic,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //تشغيل الصوت
                      if (controller.audioPath.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                              color: const Color(0xff6DC1CF),
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                              onPressed: () {
                                controller.playRecording();
                              },
                              icon: Icon(
                                controller.ispaly
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                              )),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff6DC1CF),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () => controller.saveAudio(),
                    child: const Text(
                      "حفظ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
