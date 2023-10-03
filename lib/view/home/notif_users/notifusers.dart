import 'package:flutter/material.dart';

class Notifusers extends StatelessWidget {
  const Notifusers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7F6F3),
      body: Column(children: [
        Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 220,
            width: 250,
          ),
        ),
        const Text(
          "ارسال اشعارات للمستخدمين",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //switch
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        //name user and icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/p.png"),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("اسم المستخدم",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('السماح بارسال الاشعارات',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Switch(
                              value: true,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        )
      ]),
    );
  }
}
