import 'package:book_store/data/model/body/register_model.dart';
import 'package:book_store/data/model/response/response_model.dart';
import 'package:book_store/data/repository/auth_repo.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo}) {
    _notification = authRepo.isNotificationActive();
  }

  bool _isLoading = false;
  bool _notification = true;

  bool get isLoading => _isLoading;
  bool get notification => _notification;

  Future<ResponseModel> registration(RegisterModel registerModel) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(registerModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      await authRepo.updateToken();

      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(email: phone, password: password);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      await authRepo.updateToken();

      responseModel = ResponseModel(true,
          '${response.body['is_phone_verified']}${response.body['token']}');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  bool clearSharedAddress() {
    return authRepo.clearSharedAddress();
  }

  void saveUserNumberAndPassword(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  String getUserNumber() {
    return authRepo.getUserEmail();
  }

  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  // bool setNotificationActive(bool isActive) {
  //   _notification = isActive;
  //   authRepo.setNotificationActive(isActive);
  //   update();
  //   return _notification;
  // }
}
