import 'package:flutter/material.dart';

import '../constants/constant.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final double height;
  final bool alignCenter;
  
  const ActionButton({super.key, required this.title, required this.onTap, this.height = 60, this.alignCenter = true});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignCenter ? Alignment.center : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Container(
          width: 250,
          height: height,
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
