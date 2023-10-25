import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;
  AppLocalization(this.locale);
  late Map<String, String> _localizedMap;

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  Future<void> load() async {
    late String jsonStringValues;
    try {
      jsonStringValues =
          await rootBundle.loadString('lib/project/localization/lang/en.json');
    } catch (e) {
      print(e.toString());
    }
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedMap =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedMap[key];
  }

  Map<String, String> localizedMap() => _localizedMap;

// static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<AppLocalization> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      // 'ar',
      'de',
      'es',
      'fr',
      'hi',
      'ja',
      'ko',
      'pt',
      'ru',
      'tr',
      'vi',
      'zh'
    ].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = new AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
