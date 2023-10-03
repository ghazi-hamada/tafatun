import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  const LineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      height: 4,
      decoration: BoxDecoration(
        color: const Color(0xFFE3F5F3),
        borderRadius: BorderRadius.circular(60),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE3F5F3),
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
