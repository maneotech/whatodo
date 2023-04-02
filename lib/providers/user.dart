import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatodo/models/user.dart';

class UserProvider with ChangeNotifier {
  String _firstname = "";
  String get firstname => _firstname;

  int _token = 0;
  int get token => _token;

  init() async {}

  setUser(UserModel userModel) {
    _firstname = userModel.firstname;
    setToken(userModel.token);
  }

  setToken(int token) {
    if (token < 0) {
      return;
    }

    _token = token;
  }

  spendOneToken() {
    if (token >= 1) {
      _token -= 1;
    } else {
      _token = 0;
    }

    notifyListeners();
  }
}
