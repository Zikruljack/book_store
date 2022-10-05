import 'dart:convert';

import 'package:book_store/controller/splash_controller.dart';
import 'package:book_store/pages/screens/dashboard/Dashboard.dart';
import 'package:book_store/pages/screens/update/update_screen.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String onBoarding = '/on-boarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String orderDetails = '/order-details';
  static const String orderSuccess = '/order-successful';
  static const String orderTracking = '/track-order';
  static const String categories = '/categories';
  static const String categoryItem = '/category-item';
  static const String payment = '/payment';
  static const String checkout = '/checkout';
  static const String cart = '/cart';
  static const String wishlist = '/wishlist';
  static const String order = '/order';
  static const String itemDetails = '/item-details';

  static String getInitialRoute() => initial;
  static String getSplashRoute(int orderID) => '$splash?id=$orderID';
  static String getLanguageRoute(String page) => '$language?page=$page';
  static String getOnBoardingRoute() => onBoarding;
  static String getSignInRoute(String page) => '$login?page=$page';
  static String getSignUpRoute() => register;
  static String getMainRoute(String page) => '$home?page=$page';
  static String getOrderDetailsRoute(int orderID) {
    return '$orderDetails?id=$orderID';
  }

  static String getOrderSuccessRoute(String orderID, String status) {
    return '$orderSuccess?id=$orderID&type=delivery&status=$status';
  }

  static String getProfileRoute() => profile;
  static String getPaymentRoute(String id, int user, String type) =>
      '$payment?id=$id&user=$user&type=$type';
  static String getCheckoutRoute(String page) => '$checkout?page=$page';
  static String getOrderTrackingRoute(int id) => '$orderTracking?id=$id';
  static String getCategoryRoute() => categories;
  static String getCategoryItemRoute(int id, String name) {
    List<int> encoded = utf8.encode(name);
    String data = base64Encode(encoded);
    return '$categoryItem?id=$id&name=$data';
  }

  static String getCartRoute() => cart;
  static String getOrderRoute() => order;
  static String getItemDetailsRoute(int itemID) =>
      '$itemDetails?id=$itemID&page=itemId';

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => getRoute(const DashBoardScreen(
              pageIndex: 0,
            ))),
    // GetPage(
    //   name: splash,
    //   page: () => SplashScreen(
    //     orderID: Get.parameters['id'] == 'null' ? null : Get.parameters['id'],
    //   ),
    // ),
    // GetPage(
    //     name: language,
    //     page: () => ChooseLangScreen(
    //         fromMenu: Get.parameters['page'] == splash ||
    //             Get.parameters['page'] == onBoarding)),
    // GetPage(name: onBoarding, page: () => OnBoardingScreen()),
    // GetPage(
    //     name: login,
    //     page: () => LoginScreen(
    //           exitFromApp: Get.parameters['page'] == signUp ||
    //               Get.parameters['page'] == splash ||
    //               Get.parameters['page'] == onBoarding,
    //         )),
    // GetPage(name: register, page: () => RegisterScreen()),
    // GetPage(
    //   name: home,
    //   page: () => getRoute(
    //     DashBoardScreen(
    //       pageIndex: Get.parameters['page'] == 'home'
    //           ? 0
    //           : Get.parameters['page'] == 'wishlist'
    //               ? 1
    //               : Get.parameters['page'] == 'cart'
    //                   ? 2
    //                   : Get.parameters['page'] == 'order'
    //                       ? 3
    //                       : Get.parameters['page'] == 'profile'
    //                           ? 4
    //                           : 0,
    //     ),
    //   ),
    // ),
    // GetPage(
    //     name: orderDetails,
    //     page: () {
    //       return getRoute(Get.arguments ??
    //           OrderDetailsScreen(
    //               orderId: int.parse(Get.parameters['id'] ?? '0'),
    //               orderModel: null));
    //     }),
    // GetPage(name: profile, page: () => getRoute(ProfileScreen())),
    // GetPage(
    //     name: payment,
    //     page: () => getRoute(PaymentScreen(
    //         orderModel: OrderModel(
    //             id: int.parse(Get.parameters['id']!),
    //             orderType: Get.parameters['type'],
    //             userId: int.parse(
    //               Get.parameters['user']!,
    //             ))))),
    // GetPage(
    //     name: checkout,
    //     page: () {
    //       CheckoutScreen checkoutScreen = Get.arguments;
    //       bool fromCart = Get.parameters['page'] == 'cart';
    //       return getRoute(checkoutScreen ??
    //           (!fromCart
    //               ? NotFound()
    //               : CheckoutScreen(
    //                   cartList: null,
    //                   fromCart: Get.parameters['page'] == 'cart',
    //                 )));
    //     }),
    // GetPage(
    //     name: orderTracking,
    //     page: () =>
    //         getRoute(OrderTrackingScreen(orderID: Get.parameters['id']))),
    // GetPage(name: categories, page: () => getRoute(CategoryScreen())),
    // GetPage(
    //     name: categoryItem,
    //     page: () {
    //       List<int> decode =
    //           base64Decode(Get.parameters['name'].replaceAll(' ', '+'));
    //       String data = utf8.decode(decode);
    //       return getRoute(CategoryItemScreen(
    //           categoryID: Get.parameters['id'], categoryName: data));
    //     }),
    // GetPage(name: cart, page: () => getRoute(CartScreen(fromNav: false))),
    // GetPage(name: order, page: () => getRoute(OrderScreen())),
    // GetPage(
    //     name: itemDetails,
    //     page: () => getRoute(Get.arguments ??
    //         ItemDetailsScreen(
    //             item: Item(id: int.parse(Get.parameters['id'])),
    //             inStorePage: Get.parameters['page'] == 'item'))),
  ];

  static getRoute(Widget navigateTo) {
    int minimumVersion = 0;
    if (GetPlatform.isAndroid) {
      minimumVersion =
          Get.find<SplashController>().configModel.appMinimumVersionAndroid!;
    } else if (GetPlatform.isIOS) {
      minimumVersion =
          Get.find<SplashController>().configModel.appMinimumVersionIos!;
    }
    return AppConstant.appVersion < minimumVersion
        ? const UpdateScreen(isUpdate: true)
        : Get.find<SplashController>().configModel.maintenanceMode!
            ? const UpdateScreen(isUpdate: false)
            : navigateTo;
  }
}
