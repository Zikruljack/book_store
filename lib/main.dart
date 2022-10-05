import 'package:book_store/controller/auth_controller.dart';
import 'package:book_store/controller/localization_controller.dart';
import 'package:book_store/controller/splash_controller.dart';
import 'package:book_store/controller/theme_controller.dart';
import 'package:book_store/helper/route_helper.dart';
import 'package:book_store/theme/dark_theme.dart';
import 'package:book_store/theme/light_theme.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'helper/get_di.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationnsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Map<String, Map<String, String>> languages = await di.init();

  int? orderID;

  runApp(MyApp(
    languages: languages,
    orderID: orderID!,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final int orderID;

  const MyApp({super.key, required this.languages, required this.orderID});

  void _route() {
    Get.find<SplashController>().getConfigData().then((bool isSuccess) async {
      if (isSuccess) {
        if (Get.find<AuthController>().isLoggedIn()) {
          Get.find<AuthController>().updateToken();
          // await Get.find<WishListController>().getWishList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isWeb) {
      Get.find<SplashController>().initSharedData();
      // Get.find<CartController>().getCartData();
      _route();
    }

    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return GetBuilder<SplashController>(
              builder: (splashController) {
                return GetMaterialApp(
                  title: AppConstant.appName,
                  debugShowCheckedModeBanner: false,
                  navigatorKey: Get.key,
                  scrollBehavior: const MaterialScrollBehavior().copyWith(
                    dragDevices: {
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.touch
                    },
                  ),
                  theme: themeController.darkTheme
                      ? themeController.darkColor == null
                          ? dark()
                          : dark(color: themeController.darkColor)
                      : themeController.lightColor == null
                          ? light()
                          : light(color: themeController.lightColor),
                  // locale: localizeController.locale,
                  translations: Messages(languages: languages),
                  fallbackLocale: Locale(AppConstant.languages[0].languageCode,
                      AppConstant.languages[0].countryCode),
                  initialRoute: GetPlatform.isWeb
                      ? RouteHelper.getInitialRoute()
                      : RouteHelper.getSplashRoute(orderID),
                  getPages: RouteHelper.routes,
                  defaultTransition: Transition.topLevel,
                  transitionDuration: const Duration(milliseconds: 500),
                );
              },
            );
          },
        );
      },
    );
  }
}
