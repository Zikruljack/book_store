import "package:flutter/material.dart";

class AppConstants {
  static Color primaryColor = const Color(0xFF1BBA85);
  static Color headingColor = const Color(0xFF1c1f35);
  static Color backgroundColor = const Color(0XFFEEEEEE);
  static Color bodyColor = const Color(0XFF6C757d);
  static Color borderColor = const Color(0xFFEBEBEB);
}

class StringConstants {
  //uri
  static const String baseUrl = 'http://192.168.1.4:3000/api';
  static const String loginUri = '/users/login';
  static const String socialLoginUri = '';
  static const String registrationUri = '/users/register';
  static const String checkEmailUri = '';
  static const String verifyEmailUri = '';
  static const String checkPhoneUri = '';
  static const String verifyPhoneUri = '';
  static const String verifyOtpUri = '';
  static const String resetPasswordUri = '';
  static const String forgetPasswordUri = '';
  static const String tokenUri = '';

  //string constant sharedPreferences
  static String token = 'BongJongToken';
  static const String topic = 'book_store';
  static const String currency = 'Rupiah';
  static const String user = 'user';
  static const String userPassword = 'user_password';
  static const String userEmail = 'user_email';
}
