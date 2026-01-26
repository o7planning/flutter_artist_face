import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/language_model.dart';

class LocalizationController extends GetxController implements GetxService {
  final String _keyLanguageCode = "___language_code___";

  late SharedPreferences sharedPreferences;

  late List<LanguageModel> languages;

  late Locale _locale;
  int _selectedIndex = 0;
  bool _isLtr = true;

  LocalizationController({
    required this.sharedPreferences,
    required this.languages,
  }) {
    loadCurrentLanguage();
    _locale = Locale(languages[0].languageCode, languages[0].countryCode);
  }

  Locale get locale => _locale;

  bool get isLtr => _isLtr;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    saveLanguage(_locale);
    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
      sharedPreferences.getString(_keyLanguageCode) ??
          languages[0].languageCode,
      sharedPreferences.getString(_keyLanguageCode) ?? languages[0].countryCode,
    );
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < languages.length; index++) {
      if (languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(_keyLanguageCode, locale.languageCode);
    sharedPreferences.setString(_keyLanguageCode, locale.countryCode!);
  }

  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }
}
