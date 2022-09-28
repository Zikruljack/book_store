import 'dart:convert';

import 'package:book_store/data/models/user_model.dart';
import 'package:book_store/data/services/error_handling.dart';
import 'package:book_store/pages/auth/login.dart';
import 'package:book_store/pages/home/homepage.dart';
import 'package:book_store/providers/user_provider.dart';
import 'package:book_store/utils/const.dart';
import 'package:book_store/utils/global_function.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<void> signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String fullName,
      required String phoneNumber}) async {
    try {
      User user = User(
        id: '',
        name: fullName,
        password: password,
        email: email,
        address: '',
        token: '',
        // cart: [],
      );
      http.Response res = await http.post(
          Uri.parse('http://192.168.1.4:3000/api/users/register'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      print(res.statusCode);
      if (res.statusCode == 201) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const LoginPage()));
      } else {
        GlobalFunction().showSnackBar(context, 'server Error');
      }
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
          GlobalFunction().showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      GlobalFunction().showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('http://192.168.1.4:3000/api/users/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // SharedPreferences prefs = await SharedPreferences.getInstance();

          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          // await prefs.setString('auth', jsonDecode(res.body)['token']);

          // ignore: use_build_context_synchronously
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
        },
      );
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (_) => const HomePage()));
    } catch (e) {
      GlobalFunction().showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('${StringConstants.baseUrl}/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('${StringConstants.baseUrl}/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        // ignore: use_build_context_synchronously
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      GlobalFunction().showSnackBar(context, e.toString());
    }
  }
}
