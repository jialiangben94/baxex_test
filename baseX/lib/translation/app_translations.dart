import 'dart:io';

import 'package:baseX/baseX.dart';
import 'package:baseX/const/share_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageModel {
  final String title;
  final String code;
  LanguageModel({
    this.title,
    this.code,
  });
}

AppTranslationX appTranslationX;

abstract class AppTranslationX<T> {
  Locale appLocale;

  List<LanguageModel> get LANG_LIST;

  String translate(String key, String languageCode, List<T> list);

  T fromJson(dynamic source);

  AppLocalizationsX<T> appLocalizationsX = AppLocalizationsX<T>();

  List<String> getLanguageList() {
    return LANG_LIST.map((e) => e.code).toList();
  }

  Future<File> writeLabel(String data) async {
    return await appLocalizationsX.labelUtil.writeLabel(data);
  }

  Locale fetchLocale() {
    var code = SharePref.sharePref.languageCode;
    appLocale = Locale(code);
    return appLocale;
  }

  String fetchLanguageCode() {
    return SharePref.sharePref.languageCode;
  }

  void changeLanguage(String langCode) async {
    appLocale = Locale(langCode);
    await SharePref.sharePref.saveLanguageCode(langCode);
    baseConstant.languageCode.value = langCode;
    Get.updateLocale(appLocale);
  }
}
