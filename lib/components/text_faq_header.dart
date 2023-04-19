import 'package:flutter/material.dart';

class TextFaqHeader extends StatelessWidget {
  final String text;
  const TextFaqHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Text(text,
          style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black,
              fontFamily: "Hellix",
              fontWeight: FontWeight.w700)),
    );
  }
}
