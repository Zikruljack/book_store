import 'package:book_store/data/model/response/publisher_model.dart';

class PaginatedOrderModel {
  int? totalSize;
  String? limit;
  int? offset;
  List<OrderModel>? orders;

  PaginatedOrderModel({this.totalSize, this.limit, this.offset, this.orders});

  PaginatedOrderModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'].toString();
    offset =
        (json['offset'] != null && json['offset'].toString().trim().isNotEmpty)
            ? int.parse(json['offset'].toString())
            : null;
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders!.add(OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderModel {
  int? id;
  int? userId;
  double? orderAmount;

  String? paymentStatus;
  String? orderStatus;

  String? paymentMethod;

  String? orderType;
  String? createdAt;
  String? updatedAt;

  String? scheduleAt;

  String? pending;
  String? accepted;
  String? confirmed;
  String? processing;
  String? handover;
  String? pickedUp;
  String? delivered;
  String? canceled;
  String? refundRequested;
  String? refunded;
  int? scheduled;
  String? failed;
  int? detailsCount;
  String? orderAttachment;
  Publisher? publisher;
  // AddressModel deliveryAddress;
  // AddressModel receiverDetails;

  OrderModel({
    this.id,
    this.userId,
    this.orderAmount,
    this.paymentStatus,
    this.orderStatus,
    this.paymentMethod,
    this.orderType,
    this.createdAt,
    this.updatedAt,
    this.scheduleAt,
    this.pending,
    this.accepted,
    this.confirmed,
    this.processing,
    this.handover,
    this.pickedUp,
    this.delivered,
    this.canceled,
    this.refundRequested,
    this.refunded,
    this.scheduled,
    this.failed,
    this.detailsCount,
    this.publisher,
    this.orderAttachment,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['order_amount'].toDouble();

    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    orderType = json['order_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    scheduleAt = json['schedule_at'];
    pending = json['pending'];
    accepted = json['accepted'];
    confirmed = json['confirmed'];
    processing = json['processing'];
    handover = json['handover'];
    pickedUp = json['picked_up'];
    delivered = json['delivered'];
    canceled = json['canceled'];
    refundRequested = json['refund_requested'];
    refunded = json['refunded'];
    scheduled = json['scheduled'];
    failed = json['failed'];
    detailsCount = json['details_count'];
    orderAttachment = json['order_attachment'];

    publisher =
        json['store'] != null ? publisher!.fromJson(json['store']) : null;
    // deliveryAddress = json['delivery_address'] != null
    //     ? AddressModel.fromJson(json['delivery_address'])
    //     : null;
    // receiverDetails = json['receiver_details'] != null
    //     ? AddressModel.fromJson(json['receiver_details'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['order_amount'] = orderAmount;
    data['payment_status'] = paymentStatus;
    data['order_status'] = orderStatus;
    data['payment_method'] = paymentMethod;
    data['order_type'] = orderType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['schedule_at'] = scheduleAt;
    data['pending'] = pending;
    data['accepted'] = accepted;
    data['confirmed'] = confirmed;
    data['processing'] = processing;
    data['handover'] = handover;
    data['picked_up'] = pickedUp;
    data['delivered'] = delivered;
    data['canceled'] = canceled;
    data['refund_requested'] = refundRequested;
    data['refunded'] = refunded;
    data['scheduled'] = scheduled;
    data['failed'] = failed;
    data['order_attachment'] = orderAttachment;

    data['details_count'] = detailsCount;
    if (publisher != null) {
      data['publisher'] = publisher!.toJson();
    }
    // if (deliveryAddress != null) {
    //   data['delivery_address'] = deliveryAddress.toJson();
    // }
    // if (receiverDetails != null) {
    //   data['receiver_details'] = receiverDetails.toJson();
    // }

    return data;
  }
}
