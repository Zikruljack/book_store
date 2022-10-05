import 'dart:convert';

import 'package:book_store/data/model/response/error_responses.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;

class ApiClient extends GetxService {
  late final String appBaseUrl;
  late final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection to api server failed'.tr;
  final int timeoutInSecond = 30;

  late String token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstant.token)!;
    if (Foundation.kDebugMode) {
      print('Token: $token');
    }
    // AddressModel addressModel;
    // try {
    //   addressModel = AddressModel.fromJson(
    //       jsonDecode(sharedPreferences.getString(AppConstant.userAddress)!));
    // } catch (e) {}

    updateHeader(
      token,
      sharedPreferences.getString(AppConstant.languageCode)!,
    );
  }
  void updateHeader(String token, String languageCode) {
    var localizationKey;
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstant.localizationKey: languageCode,
      'Authorization': 'Bearer $token'
    };
    _mainHeaders = header;
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body with ${multipartBody.length} picture');
      }
      Http.MultipartRequest request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        Uint8List list = await multipart.file.readAsBytes();
        request.files.add(Http.MultipartFile(
          multipart.key,
          multipart.file.readAsBytes().asStream(),
          list.length,
          filename: '${DateTime.now().toString()}.png',
        ));
      }
      request.fields.addAll(body);
      Http.Response response =
          await Http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      Http.Response response = await Http.get(
        Uri.parse(appBaseUrl + uri),
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSecond));
      return handleResponse(response, uri);
    } catch (e) {
      print('------------${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      Http.Response response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSecond));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      Http.Response response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSecond));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      Http.Response response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSecond));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {}
    Response responses = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (responses.statusCode != 200 &&
        responses.body != null &&
        responses.body is! String) {
      if (responses.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(responses.body);
        responses = Response(
            statusCode: responses.statusCode,
            body: responses.body,
            statusText: errorResponse.errors[0].message);
      } else if (responses.body.toString().startsWith('{message')) {
        responses = Response(
            statusCode: responses.statusCode,
            body: responses.body,
            statusText: responses.body['message']);
      }
    } else if (responses.statusCode != 200 && responses.body == null) {
      responses = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if (Foundation.kDebugMode) {
      print(
          '====> API Response: [${responses.statusCode}] $uri\n${responses.body}');
    }
    return responses;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
