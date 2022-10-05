import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class PublisherRepo {
  final ApiClient apiClient;
  PublisherRepo({required this.apiClient});

  Future<Response> getPublisherList(int offset, String filterBy) async {
    return await apiClient.getData(
        '${AppConstant.publisherUri}/$filterBy?offset=$offset&limit=10');
  }

  // Future<Response> getPopularPublisherList(String type) async {
  //   return await apiClient
  //       .getData('${AppConstant.POPULAR_STORE_URI}?type=$type');
  // }

  // Future<Response> getLatestPublisherList(String type) async {
  //   return await apiClient
  //       .getData('${AppConstants.LATEST_STORE_URI}?type=$type');
  // }

  // Future<Response> getFeaturedPublisherList() async {
  //   return await apiClient
  //       .getData('${AppConstants.STORE_URI}/all?featured=1&offset=1&limit=50');
  // }

  Future<Response> getPublisherDetails(String publisherID) async {
    return await apiClient.getData('${AppConstant.publisherUri}$publisherID');
  }

  Future<Response> getPublisherItemList(
      int publisherID, int offset, int categoryID, String type) async {
    return await apiClient.getData(
      '${AppConstant.bookUri}?publisherId=$publisherID&category_id=$categoryID&offset=$offset&limit=10&type=$type',
    );
  }

  Future<Response> getPublisherSearchItemList(
      String searchText, String publisherID, int offset, String type) async {
    return await apiClient.getData(
      '${AppConstant.searchUri}items/search?store_id=$publisherID&name=$searchText&offset=$offset&limit=10&type=$type',
    );
  }

  // Future<Response> getPublisherReviewList(String publisherID) async {
  //   return await apiClient
  //       .getData('${AppConstants.STORE_REVIEW_URI}?store_id=$publisherID');
  // }
}
