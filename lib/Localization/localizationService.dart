import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'en_US.dart';

class LocalizationService extends Translations {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static Locale _local = const Locale('en', 'US');
  static Locale get locale => _local;
  static const fallbackLocale = Locale('en', 'US');

  static final List localeList = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
  ];

  static Future<void> init() async {
    final SharedPreferences preferences = await _prefs;
    _local = Locale(preferences.getString('language_code') ?? 'en');
    preferences.getString("country_code") ?? 'US';
  }

  static Future<void> setLocal(
      {required String languageCode, required String countryCode}) async {
    final SharedPreferences preferences = await _prefs;
    await preferences.setString("language_code", "");
    await preferences.setString("country_code", "");
  }

  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS};
}
