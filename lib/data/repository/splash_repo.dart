import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  ApiClient apiClient;
  SharedPreferences sharedPreferences;
  SplashRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> getConfigData() async {
    return await apiClient.getData(AppConstant.configUri);
  }

  Future<void> initSharedData() async {
    if (!sharedPreferences.containsKey(AppConstant.theme)) {
      sharedPreferences.setBool(AppConstant.theme, false);
    }
    if (!sharedPreferences.containsKey(AppConstant.languageCode)) {
      sharedPreferences.setString(
          AppConstant.languageCode, AppConstant.languages[0].languageCode);
    }
    if (!sharedPreferences.containsKey(AppConstant.cartList)) {
      sharedPreferences.setStringList(AppConstant.cartList, []);
    }
    if (!sharedPreferences.containsKey(AppConstant.searchHistory)) {
      sharedPreferences.setStringList(AppConstant.searchHistory, []);
    }
    if (!sharedPreferences.containsKey(AppConstant.notification)) {
      sharedPreferences.setBool(AppConstant.notification, true);
    }
    if (!sharedPreferences.containsKey(AppConstant.intro)) {
      sharedPreferences.setBool(AppConstant.intro, true);
    }
    if (!sharedPreferences.containsKey(AppConstant.notificationCount)) {
      sharedPreferences.setInt(AppConstant.notificationCount, 0);
    }
  }

  void disableIntro() {
    sharedPreferences.setBool(AppConstant.intro, false);
  }

  bool showIntro() {
    return sharedPreferences.getBool(AppConstant.intro)!;
  }

  Future<void> setStoreCategory(int storeCategoryID) async {
    // AddressModel addressModel;
    // try {
    //   addressModel = AddressModel.fromJson(
    //       jsonDecode(sharedPreferences.getString(AppConstant.USER_ADDRESS)));
    // } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstant.token)!,
      sharedPreferences.getString(AppConstant.languageCode)!,
    );
  }
}
