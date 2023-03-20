import 'package:flutter/material.dart';

import '../constants/constant.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const ActionButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    /* LinearGradient gradient =
        const LinearGradient(colors: [Colors.indigo, Colors.pink]);*/

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
  /*return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: ,
            border: Border.all(
              color: Color(0xff000000),
              
              width: 1,
            ),
            color: Colors.blue,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(title, style: Constants.activityHeaderTextStyle),
          ),
        ),
      ),
    );
  }*/
}
