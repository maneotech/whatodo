import 'package:flutter/material.dart';

import '../constants/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Buttons { facebook, apple, google, email }

class InformationButton {
  final String text;
  final Color backgroundColor;
  final Icon icon;

  InformationButton(this.text, this.backgroundColor, this.icon);
}

class SignInButton extends StatelessWidget {
  final Buttons button;
  final Function onPressed;

  const SignInButton(
      {super.key, required this.button, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    InformationButton infoButton = getInformationButton(context);

    return Padding(
      padding: Constants.paddingButtons,
      child: ElevatedButton.icon(
        onPressed: (){onPressed();},
        icon: infoButton.icon,
        label: Text(
          infoButton.text,
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          backgroundColor: infoButton.backgroundColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(16.0),
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }

  InformationButton getInformationButton(BuildContext context) {
    InformationButton infoButton;

    switch (button) {
      case Buttons.facebook:
        infoButton = InformationButton(
            AppLocalizations.of(context)!.loginFb,
            const Color.fromRGBO(88, 144, 255, 1.0),
            const Icon(Icons.facebook));
        break;

      case Buttons.apple:
        infoButton = InformationButton(
            AppLocalizations.of(context)!.loginApple, Colors.black, const Icon(Icons.apple));
        break;
      case Buttons.google:
        infoButton = InformationButton(AppLocalizations.of(context)!.loginGoogle,
            const Color.fromRGBO(36, 160, 237, 1.0), const Icon(Icons.g_mobiledata));
        break;
      default:
        infoButton = InformationButton(AppLocalizations.of(context)!.loginEmail,
            Constants.primaryColor, const Icon(Icons.email));
        break;
    }

    return infoButton;
  }
}
