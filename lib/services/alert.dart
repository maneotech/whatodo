import 'package:flutter/material.dart';

class AlertService {
  static showAlertDialogTwoButtons(
    BuildContext context,
    String buttonOneText,
    String buttonTwoText,
    String title,
    String content,
    Function buttonOneCallback,
    Function buttonTwoCallback,
  ) {
    // set up the buttons
    TextButton cancelButton = TextButton(
      child: Text(buttonOneText),
      onPressed: () => buttonOneCallback(),
    );
    TextButton continueButton = TextButton(
      child: Text(buttonTwoText),
      onPressed: () => buttonTwoCallback(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
