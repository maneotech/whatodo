import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const ColorButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60.0,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xffA25CFF), Color(0xff14D88C)])),
        child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          child: Text(text),
        ),
      ),
    );
  }
}
