import 'package:book_store/controller/auth_controller.dart';
import 'package:book_store/controller/cart_controller.dart';
import 'package:book_store/controller/wishlist_controller.dart';
import 'package:book_store/data/api/api_checker.dart';
import 'package:book_store/data/model/response/response_model.dart';
import 'package:book_store/data/model/response/user_info_model.dart.dart';
import 'package:book_store/data/repository/user_repo.dart';
import 'package:book_store/helper/network_info.dart';
import 'package:book_store/helper/route_helper.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  late UserInfoModel _userInfoModel;
  late XFile _pickedFile;
  late Uint8List _rawFile;
  bool _isLoading = false;

  UserInfoModel get userInfoModel => _userInfoModel;
  XFile get pickedFile => _pickedFile;
  Uint8List get rawFile => _rawFile;
  bool get isLoading => _isLoading;

  Future<ResponseModel> getUserInfo() async {
    _pickedFile = null as XFile;
    _rawFile = null as Uint8List;
    ResponseModel responseModel;
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(response.body);
      responseModel = ResponseModel(true, 'successful');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      ApiChecker.checkApi(response);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> updateUserInfo(
      UserInfoModel updateUserModel, String token) async {
    _isLoading = true;
    update();
    ResponseModel responseModel;
    Response response =
        await userRepo.updateProfile(updateUserModel, _pickedFile, token);
    _isLoading = false;
    if (response.statusCode == 200) {
      _userInfoModel = updateUserModel;
      responseModel = ResponseModel(true, response.bodyString!);
      _pickedFile = null as XFile;
      _rawFile = null as Uint8List;
      getUserInfo();
      print(response.bodyString);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      print(response.statusText);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> changePassword(UserInfoModel updatedUserModel) async {
    _isLoading = true;
    update();
    ResponseModel responseModel;
    Response response = await userRepo.changePassword(updatedUserModel);
    _isLoading = false;
    if (response.statusCode == 200) {
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  void pickImage() async {
    _pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;
    _pickedFile = await NetworkInfo.compressImage(_pickedFile);
    _rawFile = await _pickedFile.readAsBytes();
    update();
  }

  void initData() {
    _pickedFile = null as XFile;
    _rawFile = null as Uint8List;
  }

  Future removeUser() async {
    _isLoading = true;
    update();
    Response response = await userRepo.deleteUser();
    _isLoading = false;
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'your_account_remove_successfully'.tr);
      Get.find<AuthController>().clearSharedData();
      Get.find<CartController>().clearCartList();
      Get.find<WishListController>().removeWishes();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
    } else {
      Get.back();
      ApiChecker.checkApi(response);
    }
  }
}
