import 'package:book_store/data/model/response/book_model.dart';

class OrderDetailsModel {
  int? id;
  int? itemId;
  int? orderId;
  double? price;
  Book? itemDetails;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  OrderDetailsModel({
    this.id,
    this.itemId,
    this.orderId,
    this.price,
    this.itemDetails,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    orderId = json['order_id'];
    price = json['price'].toDouble();
    itemDetails = json['item_details'] != null
        ? Book.fromJson(json['item_details'])
        : null;
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_id'] = itemId;
    data['order_id'] = orderId;
    data['price'] = price;
    data['item_details'] = itemDetails!.toJson();
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
