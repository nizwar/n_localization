import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyLocalization {
  final Locale locale;

  MyLocalization(this.locale);

  static MyLocalization of(BuildContext context) {
    return Localizations.of<MyLocalization>(context, MyLocalization);
  }

  static const LocalizationsDelegate<MyLocalization> delegate = _MyLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }
}

class _MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalization> {
  const _MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) { 
    return ['en', 'id', 'ta'].contains(locale.languageCode);
  }

  @override
  Future<MyLocalization> load(Locale locale) async { 
    MyLocalization localizations = new MyLocalization(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_MyLocalizationsDelegate old) => false;
}
