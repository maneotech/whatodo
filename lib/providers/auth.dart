import 'package:flutter/material.dart';

import '../constants/constant.dart';
import '../repositories/shared_pref.dart';

class AuthProvider with ChangeNotifier {
  String _jwt = "sdf";
  String get jwt => _jwt;

  init() async {
    await getJwtFromDisk();
  }

  getJwtFromDisk() async {
    SharedPref sharedPref = SharedPref();
    String? jsonString = await sharedPref.read(Constants.sharedPrefKeyJwt);

    if (jsonString != null && jsonString.isNotEmpty) {
      _jwt = jsonString;
      notifyListeners();
    }
  }
  

  Future<void> saveJwtToDisk(String jwt) async {
    if (jwt.isNotEmpty) {
      SharedPref sharedPref = SharedPref();
      await sharedPref.save(Constants.sharedPrefKeyJwt, jwt);
      _jwt = jwt;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    SharedPref sharedPref = SharedPref();
    await sharedPref.save(Constants.sharedPrefKeyJwt, "");
    _jwt = "";
    notifyListeners();
  }
}
