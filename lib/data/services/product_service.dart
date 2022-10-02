import 'dart:convert';

import 'package:book_store/data/models/user_model.dart';
import 'package:book_store/data/services/error_handling.dart';
import 'package:book_store/providers/user_provider.dart';
import 'package:book_store/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailServices {
  void addToCart({
    required BuildContext context,
    required product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('${StringConstants.baseUrl}/users/add-to-cart?productId=id'),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'auth': userProvider.user.token
        },
        body: jsonEncode(
          {'id': product.id},
        ),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {}
  }
}
