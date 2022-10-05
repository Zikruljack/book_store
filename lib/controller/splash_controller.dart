import 'package:book_store/data/api/api_checker.dart';
import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/data/model/response/config_model.dart';
import 'package:book_store/data/repository/splash_repo.dart';
import 'package:get/get.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  late ConfigModel _configModel;
  bool _firstTimeConnectionCheck = true;
  bool _hasConnection = true;
  Map<String, dynamic> _data = {};
  final bool _isLoading = false;

  ConfigModel get configModel => _configModel;
  DateTime get currentTime => DateTime.now();
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get hasConnection => _hasConnection;

  Future<bool> getConfigData() async {
    _hasConnection = true;

    Response response = await splashRepo.getConfigData();
    bool isSuccess = false;
    if (response.statusCode == 200) {
      _data = response.body;
      // _configModel = ConfigModel.fromJson(response.body);
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      if (response.statusText == ApiClient.noInternetMessage) {
        _hasConnection = false;
      }
      isSuccess = false;
    }
    update();
    return isSuccess;
  }

  Future<void> initSharedData() async {
    await splashRepo.initSharedData();
  }

  bool showIntro() {
    return splashRepo.showIntro();
  }

  void disableIntro() {
    splashRepo.disableIntro();
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }
}
