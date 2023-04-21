import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatodo/models/user.dart';

class UserProvider with ChangeNotifier {
  String _firstname = "";
  String get firstname => _firstname;

  int _token = 0;
  int get token => _token;

  bool _enableAdVideo = true;
  bool get enableAdVideo => _enableAdVideo;

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

  earnOneToken() {
    _token += 1;
    notifyListeners();
  }

  setGetHomeResponse(bool enableAdVideo, UserModel? user) {
    _enableAdVideo = enableAdVideo;

    if (user != null) {
      _token = user.token;
      _firstname = user.firstname;

      if (_token < 0) {
        _token = 0;
      }
    }

    notifyListeners();
  }
}
