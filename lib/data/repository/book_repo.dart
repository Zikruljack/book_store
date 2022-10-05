import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:get/get.dart';

class BookRepo extends GetxService {
  final ApiClient apiClient;
  BookRepo({required this.apiClient});

  // Future<Response> getPopularItemList(String type) async {
  //   return await apiClient.getData('${AppConstant.POPULAR_ITEM_URI}?type=$type');
  // }

  // Future<Response> getReviewedItemList(String type) async {
  //   return await apiClient.getData('${AppConstants.REVIEWED_ITEM_URI}?type=$type');
  // }

  // Future<Response> submitReview(ReviewBody reviewBody) async {
  //   return await apiClient.postData(AppConstants.REVIEW_URI, reviewBody.toJson());
  // }

  // Future<Response> submitDeliveryManReview(ReviewBody reviewBody) async {
  //   return await apiClient.postData(AppConstants.DELIVER_MAN_REVIEW_URI, reviewBody.toJson());
  // }

  Future<Response> getItemDetails(int itemID) async {
    return apiClient.getData('${AppConstant.bookUri}$itemID');
  }
}
