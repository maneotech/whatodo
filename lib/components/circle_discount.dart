import 'package:flutter/material.dart';
import 'package:whatodo/constants/constant.dart';

class CircleDiscount extends StatelessWidget {
  final String text;

  const CircleDiscount({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: Center(child: Text(text, style: Constants.discountTextStyle)),
    );
  }
}
