import 'package:flutter/material.dart';
import 'package:whatodo/services/base_api.dart';

import '../constants/constant.dart';
import '../repositories/shared_pref.dart';

class AuthProvider with ChangeNotifier {
  String _jwt = "";
  String get jwt => _jwt;

  static String bearerToken = "";

  init() async {
    await getJwtFromDisk();
  }

  getJwtFromDisk() async {
    SharedPref sharedPref = SharedPref();
    String? jsonString = await sharedPref.read(Constants.sharedPrefKeyJwt);

    if (jsonString != null && jsonString.isNotEmpty) {
      setJwt(jsonString);
      notifyListeners();
    }
  }

  Future<void> saveJwtToDisk(String jwt) async {
    if (jwt.isNotEmpty) {
      SharedPref sharedPref = SharedPref();
      await sharedPref.save(Constants.sharedPrefKeyJwt, jwt);
      setJwt(jwt);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    SharedPref sharedPref = SharedPref();
    await sharedPref.save(Constants.sharedPrefKeyJwt, "");
    setJwt("");
    notifyListeners();
  }

  setJwt(String jwt) {
    _jwt = jwt;
    AuthProvider.bearerToken = jwt;
  }

  static Map<String, String> getHeaders() {
    return {
      'Content-Type': "application/json; charset=UTF-8",
      'Authorization': "Bearer ${AuthProvider.bearerToken}"
    };
  }
}
