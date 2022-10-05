import 'dart:typed_data';

import 'package:book_store/data/api/api_checker.dart';
import 'package:book_store/data/model/response/order_detail_model.dart';
import 'package:book_store/data/model/response/order_model.dart';
import 'package:book_store/data/model/response/response_model.dart';
import 'package:book_store/data/repository/order_repo.dart';
import 'package:book_store/helper/network_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  late PaginatedOrderModel _runningOrderModel;
  late PaginatedOrderModel _historyOrderModel;
  late List<OrderDetailsModel> _orderDetails;
  int _paymentMethodIndex = 0;
  late OrderModel _trackModel;
  late ResponseModel _responseModel;
  bool _isLoading = false;
  bool _showCancelled = false;
  String _orderType = 'delivery';
  int _selectedDateSlot = 0;
  int _selectedTimeSlot = 0;
  late double _distance;
  int _addressIndex = -1;
  late XFile _orderAttachment;
  late Uint8List _rawAttachment;

  PaginatedOrderModel get runningOrderModel => _runningOrderModel;
  PaginatedOrderModel get historyOrderModel => _historyOrderModel;
  List<OrderDetailsModel> get orderDetails => _orderDetails;
  int get paymentMethodIndex => _paymentMethodIndex;
  OrderModel get trackModel => _trackModel;
  ResponseModel get responseModel => _responseModel;
  bool get isLoading => _isLoading;
  bool get showCancelled => _showCancelled;
  String get orderType => _orderType;

  int get selectedDateSlot => _selectedDateSlot;
  int get selectedTimeSlot => _selectedTimeSlot;
  double get distance => _distance;
  int get addressIndex => _addressIndex;
  XFile get orderAttachment => _orderAttachment;
  Uint8List get rawAttachment => _rawAttachment;

  Future<void> getRunningOrders(int offset) async {
    if (offset == 1) {
      _runningOrderModel = null as PaginatedOrderModel;
      update();
    }
    Response response = await orderRepo.getRunningOrderList(offset);
    if (response.statusCode == 200) {
      if (offset == 1) {
        _runningOrderModel = PaginatedOrderModel.fromJson(response.body);
      } else {
        _runningOrderModel.orders!
            .addAll(PaginatedOrderModel.fromJson(response.body).orders!);
        _runningOrderModel.offset =
            PaginatedOrderModel.fromJson(response.body).offset;
        _runningOrderModel.totalSize =
            PaginatedOrderModel.fromJson(response.body).totalSize;
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getHistoryOrders(int offset) async {
    if (offset == 1) {
      _historyOrderModel = null as PaginatedOrderModel;
      update();
    }
    Response response = await orderRepo.getHistoryOrderList(offset);
    if (response.statusCode == 200) {
      if (offset == 1) {
        _historyOrderModel = PaginatedOrderModel.fromJson(response.body);
      } else {
        _historyOrderModel.orders!
            .addAll(PaginatedOrderModel.fromJson(response.body).orders!);
        _historyOrderModel.offset =
            PaginatedOrderModel.fromJson(response.body).offset;
        _historyOrderModel.totalSize =
            PaginatedOrderModel.fromJson(response.body).totalSize;
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<List<OrderDetailsModel>> getOrderDetails(String orderID) async {
    _orderDetails = null as List<OrderDetailsModel>;
    _isLoading = true;
    _showCancelled = false;

    if (_trackModel.orderType != 'parcel') {
      Response response = await orderRepo.getOrderDetails(orderID);
      _isLoading = false;
      if (response.statusCode == 200) {
        _orderDetails = [];
        response.body.forEach((orderDetail) =>
            _orderDetails.add(OrderDetailsModel.fromJson(orderDetail)));
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      _isLoading = false;
      _orderDetails = [];
    }
    update();
    return _orderDetails;
  }

  void setPaymentMethod(int index) {
    _paymentMethodIndex = index;
    update();
  }

  Future<ResponseModel> trackOrder(
      String orderID, OrderModel orderModel, bool fromTracking) async {
    _trackModel = null as OrderModel;
    _responseModel = null as ResponseModel;
    if (!fromTracking) {
      _orderDetails = null as List<OrderDetailsModel>;
    }
    _showCancelled = false;
    if (orderModel == null) {
      _isLoading = true;
      Response response = await orderRepo.trackOrder(orderID);
      if (response.statusCode == 200) {
        _trackModel = OrderModel.fromJson(response.body);
        _responseModel = ResponseModel(true, response.body.toString());
      } else {
        _responseModel = ResponseModel(false, response.statusText!);
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    } else {
      _trackModel = orderModel;
      _responseModel = ResponseModel(true, 'Successful');
    }
    return _responseModel;
  }

  // Future<void> placeOrder(PlaceOrderBody placeOrderBody,
  //     Function(bool isSuccess, String message, String orderID) callback) async {
  //   _isLoading = true;
  //   update();
  //   print(placeOrderBody.toJson());
  //   Response response =
  //       await orderRepo.placeOrder(placeOrderBody, _orderAttachment);
  //   _isLoading = false;
  //   if (response.statusCode == 200) {
  //     String message = response.body['message'];
  //     String orderID = response.body['order_id'].toString();
  //     callback(true, message, orderID);
  //     _orderAttachment = null as XFile;
  //     _rawAttachment = null as Uint8List;
  //     print('-------- Order placed successfully $orderID ----------');
  //   } else {
  //     callback(false, response.statusText!, '-1');
  //   }
  //   update();
  // }

  void stopLoader() {
    _isLoading = false;
    update();
  }

  void clearPrevData() {
    _addressIndex = -1;
    _paymentMethodIndex = 0;
    _selectedDateSlot = 0;
    _selectedTimeSlot = 0;
    _orderAttachment = null as XFile;
    _rawAttachment = null as Uint8List;
  }

  void setAddressIndex(int index) {
    _addressIndex = index;
    update();
  }

  void cancelOrder(int orderID) async {
    _isLoading = true;
    update();
    Response response = await orderRepo.cancelOrder(orderID.toString());
    _isLoading = false;
    Get.back();
    if (response.statusCode == 200) {
      OrderModel? orderModel;
      for (OrderModel order in _runningOrderModel.orders!) {
        if (order.id == orderID) {
          orderModel = order;
          break;
        }
      }
      _runningOrderModel.orders!.remove(orderModel);
      _showCancelled = true;
      Fluttertoast.showToast(msg: response.body['message']);
    } else {
      print(response.statusText);
      ApiChecker.checkApi(response);
    }
    update();
  }

  void setOrderType(String type, {bool notify = true}) {
    _orderType = type;
    if (notify) {
      update();
    }
  }

  void pickImage() async {
    _orderAttachment = (await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50))!;
    _orderAttachment = await NetworkInfo.compressImage(_orderAttachment);
    _rawAttachment = await _orderAttachment.readAsBytes();
    update();
  }
}
