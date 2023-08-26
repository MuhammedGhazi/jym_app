import 'package:flutter/material.dart';
import 'package:jym_app/core/constants/constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.lable, required this.onTap});
  final String lable;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr,
        ),
        child: Center(
            child: Text(
          lable,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
