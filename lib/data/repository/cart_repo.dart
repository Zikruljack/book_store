import 'dart:convert';

import 'package:book_store/data/model/response/cart_model.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstant.cartList)) {
      carts = sharedPreferences.getStringList(AppConstant.cartList)!;
    }
    List<CartModel> cartList = [];
    for (var cart in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(cart)));
    }
    return cartList;
  }

  void addToCartList(List<CartModel> cartProductList) {
    List<String> carts = [];
    for (var cartModel in cartProductList) {
      carts.add(jsonEncode(cartModel));
    }
    sharedPreferences.setStringList(AppConstant.cartList, carts);
  }
}
