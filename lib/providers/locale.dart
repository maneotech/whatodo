import 'dart:io';

import 'package:flutter/material.dart';

import '../constants/constant.dart';
import '../repositories/shared_pref.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = Locale(Platform.localeName.substring(0, 2));

  Locale get locale => _locale;

  LocaleProvider() {
    init();
  }
  init() async {
    if (_locale.languageCode != "fr" && _locale.languageCode != "en" && _locale.languageCode != "es" ) {
      _locale = const Locale("en");
    }

    await getLanguageFromDisk();
  }

  void setLocale(Locale locale) {
    if (locale.languageCode != 'en' &&
        locale.languageCode != 'fr' &&
        locale.languageCode != 'es') {
      return;
    }

    _locale = locale;
    notifyListeners();
  }

  getLanguageFromDisk() async {
    SharedPref sharedPref = SharedPref();
    String? jsonString = await sharedPref.read(Constants.sharedPrefKeyLanguage);

    if (jsonString != null) {
      setLocale(Locale(jsonString));
    }
  }

  Future<void> saveLanguageToDisk(String languageCode) async {
    SharedPref sharedPref = SharedPref();
    await sharedPref.save(Constants.sharedPrefKeyLanguage, languageCode);
    setLocale(Locale(languageCode));
  }

  Future<void> changeLanguage(String languageCode, BuildContext context,
      [bool mounted = true]) async {
    if (languageCode != "en" && languageCode != 'fr' && languageCode != 'es') {
      return;
    }

    await saveLanguageToDisk(languageCode);
  }
}
