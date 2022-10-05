import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/data/model/response/user_info_model.dart.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstant.userInfo);
  }

  Future<Response> updateProfile(
      UserInfoModel userInfoModel, XFile data, String token) async {
    Map<String, String> body = {};
    body.addAll(<String, String>{
      'f_name': userInfoModel.fName!,
      'email': userInfoModel.email!
    });
    return await apiClient.postMultipartData(
        AppConstant.userUpdateInfo, body, [MultipartBody('image', data)]);
  }

  Future<Response> changePassword(UserInfoModel userInfoModel) async {
    return await apiClient.postData(AppConstant.userUpdateInfo, {
      'f_name': userInfoModel.fName,
      'email': userInfoModel.email,
      'password': userInfoModel.password
    });
  }

  Future<Response> deleteUser() async {
    return await apiClient.deleteData(AppConstant.userDelete);
  }
}
