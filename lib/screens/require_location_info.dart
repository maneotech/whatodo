import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:whatodo/constants/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              Text(
                AppLocalizations.of(context)!.enableLocation,
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
              Text(
                AppLocalizations.of(context)!.howToEnableLocation,
                style: Constants.activityHeaderTextStyle,
              ),
              Text(
                getText(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getText(BuildContext context) {
    String content = AppLocalizations.of(context)!.locationDefaultText;
    if (!kIsWeb) {
      if (Platform.isIOS) {
        content = AppLocalizations.of(context)!.locationDefaultTextIOS;
      }
    }

    return content;
  }
}
