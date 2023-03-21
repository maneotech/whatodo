import 'package:flutter/material.dart';

import '../constants/constant.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const ActionButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Container(
          width: 250,
          height: 60,
          color: Colors.white,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                  width: 1.0, color: Constants.lightOutlinedGreenColor),
            ),
            child: Text(
              title,
              style: Constants.activityHeaderTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
