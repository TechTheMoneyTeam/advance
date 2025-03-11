import 'package:flutter/material.dart';

class ColorTapWidget extends StatelessWidget {
  final String colorType;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTapWidget({
    Key? key,
    required this.colorType,
    required this.tapCount,
    required this.onTap,
  }) : super(key: key);

  Color get backgroundColor => 
      colorType == 'red' ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
     print("$colorType");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}