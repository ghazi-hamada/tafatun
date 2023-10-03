import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    super.key,
    required this.title,
    this.controller,
    required this.valid,
    this.obsText,
   required this.keyboardType ,
  });
  final String title;
  final TextEditingController? controller;
  final String? Function(String?) valid;
  final bool? obsText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3f000000),
                offset: Offset(0, 4),
                blurRadius: 2,
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            keyboardType: keyboardType,
            textAlign: TextAlign.left,
            strutStyle: const StrutStyle(
                fontFamily: String.fromEnvironment("defaultFloo",
                    defaultValue: "no floo")),
            validator: valid,
            obscureText: obsText ?? false,
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFF89D2C9)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFF89D2C9)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xFF89D2C9)),
              ),
              prefixIcon: Container(
                width: 100,
                height: 43,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(-0.04, -1.00),
                    end: Alignment(0.04, 1),
                    colors: [
                      Color(0xd0c8eae3),
                      Color(0xffd6ebe7),
                      Color(0xffffffff)
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1.5,
                      color: Color(0xFF89D2C9),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 3),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF080101),
                      fontSize: 15,
                      fontFamily: 'Kosugi',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              filled: true,
              fillColor: const Color(0xFFFBFFFE),
            ),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
