import 'package:flutter/material.dart';

import '../constants/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPictureTitle extends StatelessWidget {
  final List<Widget> widgets;

  const SignInPictureTitle({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              Constants.loginImage,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: Constants.paddingLogin,
              child: Text(AppLocalizations.of(context)!.loginHeadline),
            ),
            Padding(
              padding: Constants.paddingLogin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets
              )
            )
          ]
        ),
      )
    );
  }
}