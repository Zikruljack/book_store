// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:book_store/controller/auth_controller.dart';
import 'package:book_store/controller/book_controller.dart';
import 'package:book_store/controller/cart_controller.dart';
import 'package:book_store/controller/category_controller.dart';
import 'package:book_store/controller/localization_controller.dart';
import 'package:book_store/controller/onboarding_controller.dart';
import 'package:book_store/controller/order_controller.dart';
import 'package:book_store/controller/search_controller.dart';
import 'package:book_store/controller/splash_controller.dart';
import 'package:book_store/controller/user_controller.dart';
import 'package:book_store/controller/wishlist_controller.dart';
import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/data/model/response/language_model.dart';
import 'package:book_store/data/repository/auth_repo.dart';
import 'package:book_store/data/repository/book_repo.dart';
import 'package:book_store/data/repository/cart_repo.dart';
import 'package:book_store/data/repository/category_repo.dart';
import 'package:book_store/data/repository/language_repo.dart';
import 'package:book_store/data/repository/onboarding_repo.dart';
import 'package:book_store/data/repository/order_repo.dart';
import 'package:book_store/data/repository/search_repo.dart';
import 'package:book_store/data/repository/splash_repo.dart';
import 'package:book_store/data/repository/user_repo.dart';
import 'package:book_store/data/repository/wishlist_repo.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  //CORE
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstant.baseUrl, sharedPreferences: Get.find()));
  //Repository
  Get.lazyPut(
      () => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => OnBoardingRepo());
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => BookRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(
      () => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => WishListRepo(apiClient: Get.find()));

  //Controller
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(
      sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => OnBoardingController(onboardingRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => BookController(bookRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(
      () => WishListController(wishListRepo: Get.find(), itemRepo: Get.find()));
  Get.lazyPut(() => SearchController(searchRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

  // Retriving localized data
  Map<String, Map<String, String>> _languages = {};
  for (LanguageModel languageModel in AppConstant.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = {};
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;
}
