import 'package:book_store/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  late Color _lightColor;
  late Color _darkColor;

  bool get darkTheme => _darkTheme;
  Color get darkColor => _darkColor;
  Color get lightColor => _lightColor;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences.setBool(AppConstant.theme, _darkTheme);
    update();
  }

  void changeTheme(Color lightColor, Color darkColor) {
    _lightColor = lightColor;
    _darkColor = darkColor;
    update();
  }

  void _loadCurrentTheme() async {
    _darkTheme = sharedPreferences.getBool(AppConstant.theme) ?? false;
    update();
  }
}
