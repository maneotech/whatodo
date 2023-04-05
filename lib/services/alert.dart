import 'package:flutter/material.dart';

class AlertService {
  static showAlertDialogOneButton(
    BuildContext context,
    String buttonOneText,
    String title,
    String content,
    Function buttonOneCallback,
  ) {
    TextButton button = TextButton(
      child: Text(buttonOneText),
      onPressed: () => buttonOneCallback(),
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        button,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
