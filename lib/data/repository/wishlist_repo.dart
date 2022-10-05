import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class WishListRepo {
  final ApiClient apiClient;
  WishListRepo({required this.apiClient});

  Future<Response> getWishList() async {
    return await apiClient.getData(AppConstant.wihsListGetUri);
  }

  Future<Response> addWishList(int id, bool isStore) async {
    return await apiClient.postData(
        '${AppConstant.wihsListAddUri}${isStore ? 'store_id=' : 'item_id='}$id',
        null);
  }

  Future<Response> removeWishList(int id, bool isStore) async {
    return await apiClient.deleteData(
        '${AppConstant.wihsListRemoveUri}${isStore ? 'store_id=' : 'item_id='}$id');
  }
}
