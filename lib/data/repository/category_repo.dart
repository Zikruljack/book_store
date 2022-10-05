import 'package:book_store/controller/localization_controller.dart';
import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:get/get.dart';

class CategoryRepo {
  final ApiClient apiClient;

  CategoryRepo({required this.apiClient});

  Future<Response> getCategoryList(bool allCategory) async {
    return await apiClient.getData(
      AppConstant.categoryUri,
      headers: allCategory
          ? {
              'Content-Type': 'application/json; charset=UTF-8',
              AppConstant.localizationKey:
                  Get.find<LocalizationController>().locale.languageCode
            }
          : null,
    );
  }

  // Future<Response> getSubCategoryList(String parentID) async {
  //   return await apiClient.getData('${AppConstant.SUB_CATEGORY_URI}$parentID');
  // }

  Future<Response> getCategoryItemList(
      String categoryID, int offset, String type) async {
    return await apiClient.getData(
        '${AppConstant.categoryItem}$categoryID?limit=10&offset=$offset&type=$type');
  }

  Future<Response> getCategoryStoreList(
      String categoryID, int offset, String type) async {
    return await apiClient.getData(
        '${AppConstant.categoryPublisher}$categoryID?limit=10&offset=$offset&type=$type');
  }

  Future<Response> getSearchData(
      String query, String categoryID, String type) async {
    return await apiClient.getData(
      '${AppConstant.searchUri}${'items'}/search?name=$query&category_id=$categoryID&type=$type&offset=1&limit=50',
    );
  }

  // Future<Response> saveUserInterests(List<int> interests) async {
  //   return await apiClient
  //       .postData(AppConstant.INTEREST_URI, {"interest": interests});
  // }
}
