import 'package:book_store/data/api/api_client.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:cross_file/src/types/interface.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  OrderRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getRunningOrderList(int offset) async {
    return await apiClient
        .getData('${AppConstant.runningOrderListUri}?offset=$offset&limit=10');
  }

  Future<Response> getHistoryOrderList(int offset) async {
    return await apiClient
        .getData('${AppConstant.historyOrderListUri}?offset=$offset&limit=10');
  }

  Future<Response> getOrderDetails(String orderID) async {
    return await apiClient.getData('${AppConstant.orderDetailUri}$orderID');
  }

  Future<Response> cancelOrder(String orderID) async {
    return await apiClient.postData(
        AppConstant.orderCancelUri, {'_method': 'put', 'order_id': orderID});
  }

  trackOrder(String orderID) {}

  placeOrder(placeOrderBody, XFile orderAttachment) {}

  // Future<Response> trackOrder(String orderID) async {
  //   return await apiClient.getData('${AppConstant.TRACK_URI}$orderID');
  // }

  // Future<Response> placeOrder(
  //     PlaceOrderBody orderBody, XFile orderAttachment) async {
  //   return await apiClient.postMultipartData(
  //     AppConstant.PLACE_ORDER_URI,
  //     orderBody.toJson(),
  //     [MultipartBody('order_attachment', orderAttachment)],
  //   );
  // }

  // Future<Response> getDeliveryManData(String orderID) async {
  //   return await apiClient.getData('${AppConstant.LAST_LOCATION_URI}$orderID');
  // }

  // Future<Response> switchToCOD(String orderID) async {
  //   return await apiClient.postData(
  //       AppConstant.COD_SWITCH_URL, {'_method': 'put', 'order_id': orderID});
  // }

  // Future<Response> getDistanceInMeter(
  //     LatLng originLatLng, LatLng destinationLatLng) async {
  //   return await apiClient.getData('${AppConstant.DISTANCE_MATRIX_URI}'
  //       '?origin_lat=${originLatLng.latitude}&origin_lng=${originLatLng.longitude}'
  //       '&destination_lat=${destinationLatLng.latitude}&destination_lng=${destinationLatLng.longitude}');
  // }
}
