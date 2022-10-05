import 'package:book_store/controller/auth_controller.dart';
import 'package:book_store/helper/route_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      // Get.find<WishListController>().removeWishes();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
    } else {
      Fluttertoast.showToast(
          msg: response.statusText!, toastLength: Toast.LENGTH_SHORT);
    }
  }
}
