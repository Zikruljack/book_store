import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/data/model/body/register_model.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(RegisterModel registerModel) async {
    return await apiClient.postData(
        AppConstant.registerUri, registerModel.toJson());
  }

  Future<Response> login({required String email, String? password}) async {
    return await apiClient
        .postData(AppConstant.loginUri, {"phone": email, "password": password});
  }

  Future<Response> updateToken() async {
    String? deviceToken;
    if (GetPlatform.isIOS && !GetPlatform.isWeb) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        deviceToken = await _saveDeviceToken();
      }
    } else {
      deviceToken = await _saveDeviceToken();
    }
    if (!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic(AppConstant.topic);
    }
    return await apiClient.postData(
        AppConstant.tokenUri, {"_method": "put", "auth": deviceToken});
  }

  Future<String> _saveDeviceToken() async {
    String? deviceToken = '@';
    if (!GetPlatform.isWeb) {
      try {
        deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {}
    }
    print('--------Device Token---------- $deviceToken');
    return deviceToken!;
  }

  Future<Response> verifyToken(String phone, String token) async {
    return await apiClient.postData(
        AppConstant.verifyTokenUri, {"phone": phone, "reset_token": token});
  }

  // for  user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(
      token,
      sharedPreferences.getString(AppConstant.languageCode)!,
    );
    return await sharedPreferences.setString(AppConstant.token, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstant.token) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstant.token);
  }

  bool clearSharedData() {
    if (!GetPlatform.isWeb) {
      FirebaseMessaging.instance.unsubscribeFromTopic(AppConstant.topic);
      apiClient.postData(
          AppConstant.tokenUri, {"_method": "put", "cm_firebase_token": '@'});
    }
    sharedPreferences.remove(AppConstant.token);
    sharedPreferences.setStringList(AppConstant.cartList, []);
    sharedPreferences.remove(AppConstant.userAddress);
    apiClient.token = '';
    apiClient.updateHeader(
      'null',
      'null',
    );
    return true;
  }

  bool clearSharedAddress() {
    sharedPreferences.remove(AppConstant.userAddress);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await sharedPreferences.setString(AppConstant.userPassword, password);
      await sharedPreferences.setString(AppConstant.userEmail, email);
    } catch (e) {
      rethrow;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstant.userEmail) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstant.userPassword) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstant.notification) ?? true;
  }

  // void setNotificationActive(bool isActive) {
  //   if (isActive) {
  //     updateToken();
  //   } else {
  //     if (!GetPlatform.isWeb) {
  //       FirebaseMessaging.instance.unsubscribeFromTopic(AppConstant.topic);
  //       if (isLoggedIn()) {
  //         FirebaseMessaging.instance.unsubscribeFromTopic(
  //             'zone_${Get.find<LocationController>().getUserAddress().zoneId}_customer');
  //       }
  //     }
  //   }
  //   sharedPreferences.setBool(AppConstant.notification, isActive);
  // }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstant.userPassword);
    return await sharedPreferences.remove(AppConstant.userEmail);
  }
}
