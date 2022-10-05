import 'dart:convert';

import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/data/model/response/address_model.dart';
import 'package:book_store/data/model/response/language_model.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  LocalizationController(
      {required this.sharedPreferences, required this.apiClient}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstant.languages[0].languageCode,
      AppConstant.languages[0].countryCode);
  bool _isLtr = true;
  List<LanguageModel> _languages = [];

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    AddressModel addressModel;
    try {
      addressModel = AddressModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstant.userAddress)!));
    } catch (e) {}
    apiClient.updateHeader(
        sharedPreferences.getString(AppConstant.token)!, locale.languageCode);
    saveLanguage(_locale);
    // if (Get.find<LocationController>().getUserAddress() != null) {
    //   HomeScreen.loadData(true);
    // }

    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(AppConstant.languageCode) ??
            AppConstant.languages[0].languageCode,
        sharedPreferences.getString(AppConstant.countryCode) ??
            AppConstant.languages[0].countryCode);
    _isLtr = _locale.languageCode != 'en';
    for (int index = 0; index < AppConstant.languages.length; index++) {
      if (AppConstant.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstant.languages);
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstant.languageCode, locale.languageCode);
    sharedPreferences.setString(AppConstant.countryCode, locale.countryCode!);
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages = [];
      _languages = AppConstant.languages;
    } else {
      _selectedIndex = -1;
      _languages = [];
      // ignore: avoid_function_literals_in_foreach_calls
      AppConstant.languages.forEach((language) async {
        if (language.languageName.toLowerCase().contains(query.toLowerCase())) {
          _languages.add(language);
        }
      });
    }
    update();
  }
}
