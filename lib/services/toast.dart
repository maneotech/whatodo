import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  static showSuccess(String message) {
    FocusManager.instance.primaryFocus?.unfocus();

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green[50],
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  static showError(String message, {bool longLength = false}) {
    FocusManager.instance.primaryFocus?.unfocus();

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: longLength ? 10.0 : 16.0);
  }
}
