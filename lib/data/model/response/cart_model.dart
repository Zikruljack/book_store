import 'package:book_store/data/model/response/book_model.dart';

class CartModel {
  late double _price;
  late int _quantity;
  late int _stock;
  late Book _item;

  CartModel(double price, int quantity, int stock, Book item) {
    _price = price;

    _quantity = quantity;

    _stock = stock;
    _item = item;
  }

  double get price => _price;

  // ignore: unnecessary_getters_setters
  int get quantity => _quantity;
  // ignore: unnecessary_getters_setters
  set quantity(int qty) => _quantity = qty;

  int get stock => _stock;
  Book get item => _item;

  CartModel.fromJson(Map<String, dynamic> json) {
    _price = json['price'].toDouble();

    _quantity = json['quantity'];
    _stock = json['stock'];
    if (json['item'] != null) {
      _item = Book.fromJson(json['item']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = _price;

    data['quantity'] = _quantity;

    data['stock'] = _stock;
    data['item'] = _item.toJson();
    return data;
  }
}
