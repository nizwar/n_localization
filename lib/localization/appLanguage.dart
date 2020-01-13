import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _locale = Locale('en');
  Locale get locale => _locale ?? Locale("en");

  AppLanguage();

  void fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _locale = Locale('en');
      return;
    }
    _locale = Locale(prefs.getString('language_code'));
    notifyListeners();
  }

  void changeLanguage(Locale type) async {
    print(type);
    var prefs = await SharedPreferences.getInstance();
    if (_locale == type) {
      return;
    }
    _locale = type;
    notifyListeners();
    switch (type.languageCode) {
      case "en":
        await prefs.setString('language_code', 'en');
        await prefs.setString('countryCode', 'IS');
        break;
      case "id":
        await prefs.setString('language_code', 'id');
        await prefs.setString('countryCode', 'ID');
        break;
      case "ta":
        await prefs.setString('language_code', 'ta');
        await prefs.setString('countryCode', '');
    }
  }
}
