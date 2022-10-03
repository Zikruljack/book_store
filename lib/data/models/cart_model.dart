import 'dart:convert';

import 'package:book_store/data/models/user_model.dart';

class ShoppingCartModel<List> {
  late int id;
  late DateTime? paidDate;
  late String image;
  late double price;
  late bool isPaid;
  late bool isSend;
  late User userId;
  late int qty;

  ShoppingCartModel({
    required this.id,
    this.paidDate,
    required this.image,
    required this.price,
    required this.qty,
    required this.userId,
    this.isPaid = false,
    this.isSend = false,
  });

  void setQty(int i) {
    if (i < 1) {
      qty = 1;
    } else {
      qty = i;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paidDate': paidDate,
      'image': image,
      'price': price,
      'quantity': qty,
      'isPaid': isPaid,
      'isSend': isSend,
      'userId': userId
    };
  }

  factory ShoppingCartModel.fromMap(Map<String, dynamic> map) {
    return ShoppingCartModel(
      id: map['id'],
      image: map['image'],
      price: map['price'],
      qty: map['qty'],
      paidDate: map['paidDate'],
      isPaid: map['isPaid'],
      isSend: map['isSend'],
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingCartModel.fromJson(String source) =>
      ShoppingCartModel.fromMap(json.decode(source));

  ShoppingCartModel copyWith({
    int? id,
    String? image,
    double? price,
    int? qty,
    DateTime? paidDate,
    bool? isPaid,
    bool? isSend,
    User? userId,
  }) {
    return ShoppingCartModel(
      id: id ?? this.id,
      image: image ?? this.image,
      price: price ?? this.price,
      qty: qty ?? this.qty,
      paidDate: paidDate ?? this.paidDate,
      isPaid: isPaid ?? this.isPaid,
      isSend: isSend ?? this.isSend,
      userId: userId ?? this.userId,
    );
  }
}
