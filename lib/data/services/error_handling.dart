import 'dart:convert';

import 'package:book_store/utils/global_function.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 201:
      GlobalFunction().showSnackBar(context, 'Success');
      break;
    case 200:
      onSuccess();
      break;
    case 400:
      GlobalFunction().showSnackBar(context, jsonDecode(response.body)['msg']);
      print('error conn');
      break;
    case 500:
      print('error conn');
      GlobalFunction()
          .showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      GlobalFunction().showSnackBar(context, response.body);
  }
}
