import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:whatodo/constants/constant.dart';

import '../components/app_bar.dart';

class RequireLocationInfo extends StatelessWidget {
  const RequireLocationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "You must enable location",
                style: Constants.titlePlaceTextStyle,
              ),
               Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.location_on_outlined,
                      size: 100,
                    ),
                  ],
                ),
              ),
              const Text(
                "How to enable Location ?",
                style: Constants.activityHeaderTextStyle,
              ),
              Text(
                getText(),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getText() {
    String content =
        '''You can use approximate location if you prefer so.\nFollow these steps to enable location :\n
1. Swipe down from the top of the screen\n
2. Touch and hold Location . If you don't find Location : Tap Edit or Settings. Then drag Location into your Quick Settings \n
3. Tap App location permissions
Under ”Allowed all the time," “Allowed only while in use,” and “Not allowed,” find the apps that can use your phone's location \n
4. To change the app's permissions, tap it. Then, choose the location access for the app''';
    if (!kIsWeb) {
      if (Platform.isIOS) {
        content =
            '''You must enable Location to use this app. You can use approximate location if you prefer so.\n
Follow these steps to enable location : \n
1. Go to Settings > Privacy & Security > Location Services.\n
2. Make sure that Location Services is on.\n
3. Scroll down to find Whatodo app.\n
4. Tap the app and select the While Using the App option (or Always)''';
      }
    }

    return content;
  }
}
