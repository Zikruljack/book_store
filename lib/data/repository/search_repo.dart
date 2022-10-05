import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getSearchData(String query, bool isStore) async {
    return await apiClient.getData(
        '${AppConstant.searchUri}${isStore ? 'stores' : 'items'}/search?name=$query&offset=1&limit=50');
  }

  // Future<Response> getSuggestedItems() async {
  //   return await apiClient.getData(AppConstants.SUGGESTED_ITEM_URI);
  // }

  Future<bool> saveSearchHistory(List<String> searchHistories) async {
    return await sharedPreferences.setStringList(
        AppConstant.searchHistory, searchHistories);
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstant.searchHistory) ?? [];
  }

  Future<bool> clearSearchHistory() async {
    return sharedPreferences.setStringList(AppConstant.searchHistory, []);
  }
}
