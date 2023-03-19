import 'package:flutter/material.dart';

import '../constants/constant.dart';

class ActivityContainer extends StatelessWidget {
  const ActivityContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Culturel",
              style: Constants.activityTitleTextStyle,
            ),
            Container(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.add_link,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
