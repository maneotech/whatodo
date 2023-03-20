import 'package:flutter/material.dart';

import '../constants/constant.dart';

class ActivityHeaderText extends StatelessWidget {
  final String text;
  const ActivityHeaderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(text, style: Constants.activityHeaderTextStyle),
    );
  }
}