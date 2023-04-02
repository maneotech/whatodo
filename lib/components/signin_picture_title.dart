import 'package:flutter/material.dart';

import '../constants/constant.dart';

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
            const Padding(
              padding: Constants.paddingLogin,
              child: Text("Enjoy unique self-guided tour experiences"),
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