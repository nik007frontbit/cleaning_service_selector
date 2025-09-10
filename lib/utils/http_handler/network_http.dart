import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api_string.dart';
import '../../config/app_static.dart';
import '../../config/local_storage.dart';
import '../../widget/common_snackbar.dart';
import '../../widget/loading_dialog.dart';

enum ApiType {
  get,
  post,
  put,
  delete,
  getForm,
  postForm,
  putForm,
  deleteForm,
}

class HttpHandler {
  static String baseURL = APIString.baseURL;
  static final Logger _logger = Logger();

  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(LocalStorageData.token);
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<Map<String, dynamic>> getHttpMethod({
    @required String? url,
    bool isMockUrl = false,
  }) async {
    if (!await isConnected()) {
      return {
        'body': {'message': AppStatic.internetErrorMsg},
        'error': AppStatic.internetErrorMsg,
      };
    }

    final headers = await _getHeaders();
    final fullUrl = isMockUrl ? "$url" : "$baseURL$url";
    _logger.i("GET $fullUrl");

    return await safeRequest(() {
      return http.get(Uri.parse(fullUrl), headers: headers);
    });
  }

  static Future<Map<String, dynamic>> postHttpMethod({
    @required String? url,
    Map<String, dynamic>? data,
  }) async {
    if (!await isConnected()) {
      return {
        'body': {'message': AppStatic.internetErrorMsg},
        'error': AppStatic.internetErrorMsg,
      };
    }

    final headers = await _getHeaders();
    final fullUrl = "$baseURL$url";
    _logger.i("POST $fullUrl");
    _logger.d("BODY: ${jsonEncode(data)}");

    return await safeRequest(() {
      return http.post(Uri.parse(fullUrl), headers: headers, body: jsonEncode(data));
    });
  }

  static Future<Map<String, dynamic>> patchHttpMethod({
    @required String? url,
    Map<String, dynamic>? data,
  }) async {
    if (!await isConnected()) {
      return {
        'body': {'message': AppStatic.internetErrorMsg},
        'error': AppStatic.internetErrorMsg,
      };
    }

    final headers = await _getHeaders();
    final fullUrl = "$baseURL$url";
    _logger.i("PATCH $fullUrl");
    _logger.d("BODY: ${jsonEncode(data)}");

    return await safeRequest(() {
      return http.patch(Uri.parse(fullUrl), headers: headers, body: jsonEncode(data));
    });
  }

  static Future<Map<String, dynamic>> putHttpMethod({
    @required String? url,
    Map<String, dynamic>? data,
  }) async {
    if (!await isConnected()) {
      return {
        'body': {'message': AppStatic.internetErrorMsg},
        'error': AppStatic.internetErrorMsg,
      };
    }

    final headers = await _getHeaders();
    final fullUrl = "$baseURL$url";
    _logger.i("PUT $fullUrl");
    _logger.d("BODY: ${jsonEncode(data)}");

    return await safeRequest(() {
      return http.put(Uri.parse(fullUrl), headers: headers, body: jsonEncode(data));
    });
  }

  static Future<Map<String, dynamic>> deleteHttpMethod({
    @required String? url,
    Map<String, dynamic>? data,
  }) async {
    if (!await isConnected()) {
      return {
        'body': {'message': AppStatic.internetErrorMsg},
        'error': AppStatic.internetErrorMsg,
      };
    }

    final headers = await _getHeaders();
    final fullUrl = "$baseURL$url";
    _logger.i("DELETE $fullUrl");

    return await safeRequest(() {
      return http.delete(Uri.parse(fullUrl), headers: headers, body: jsonEncode(data));
    });
  }

  static Future<Map<String, dynamic>> formDataMethod({
    required String url,
    Map<String, String>? body,
    String? imagePath,
    String? apiMethod,
    List<String>? imageList,
    String? imageKey,
  }) async {
    if (!await isConnected()) {
      return {
        'body': {'message': AppStatic.internetErrorMsg},
        'error': AppStatic.internetErrorMsg,
      };
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(LocalStorageData.token);

      final request = http.MultipartRequest(
        (apiMethod ?? "POST").toUpperCase(),
        Uri.parse("$baseURL$url"),
      );

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      if (body != null) {
        request.fields.addAll(body);
        _logger.d("FORM FIELDS: $body");
      }

      if (imagePath != null) {
        _logger.d("Adding single image: $imagePath");
        request.files.add(await http.MultipartFile.fromPath(
          '$imageKey',
          imagePath,
          filename: "image.png",
          contentType: MediaType('image', 'png'),
        ));
      }

      if (imageList != null) {
        for (var element in imageList) {
          _logger.d("Adding image from list: $element");
          request.files.add(await http.MultipartFile.fromPath(
            '$imageKey',
            element,
            filename: "image.png",
            contentType: MediaType('image', 'png'),
          ));
        }
      }

      _logger.i("FORM-DATA ${request.method} $baseURL$url");

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      _logger.i("FORM-DATA RESPONSE: ${response.statusCode}");
      _logger.d("BODY: $responseBody");

      if (response.statusCode == 200) {
        return {'body': jsonDecode(responseBody), 'error': null};
      } else {
        return {
          'body': {'message': response.reasonPhrase ?? 'Error'},
          'error': responseBody
        };
      }
    } catch (e) {
      _logger.e("FormData Error: $e");
      return {
        'body': {'message': AppStatic.internetErrorMsg},
        'error': AppStatic.internetErrorMsg,
      };
    }
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    _logger.i("RESPONSE ${response.statusCode}");
    _logger.d("BODY: ${response.body}");

    try {
      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'body': decoded,
          'headers': response.headers,
          'error': null,
        };
      } else if (response.statusCode == 401) {
        _handleUnauthorized();
        return {
          'body': decoded,
          'headers': response.headers,
          'error': "Session expired.",
        };
      } else {
        return {
          'body': decoded,
          'headers': response.headers,
          'error': "Error ${response.statusCode}",
        };
      }
    } catch (e) {
      _logger.e("Response parse error: $e");
      return {
        'body': {'message': 'Invalid server response'},
        'error': 'Invalid server response',
      };
    }
  }

  static void _handleUnauthorized() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _logger.w("UNAUTHORIZED - redirecting to login");
    // Get.offAll(() => LoginView());
  }

  static Future<Map<String, dynamic>> safeRequest(
      Future<http.Response> Function() requestFunction,
      ) async {
    try {
      final response = await requestFunction();
      return _handleResponse(response);
    } on SocketException catch (e) {
      _logger.e("SocketException: $e");
      return {
        'body': {'message': AppStatic.internetErrorMsg},
        'error': AppStatic.internetErrorMsg,
      };
    } on http.ClientException catch (e) {
      _logger.e("ClientException: $e");
      return {
        'body': {'message': 'Client error: ${e.message}'},
        'error': 'Client error: ${e.message}',
      };
    } catch (e) {
      _logger.e("Unexpected error: $e");
      return {
        'body': {'message': 'Something went wrong. Please try again.'},
        'error': 'Something went wrong. Please try again.',
      };
    }
  }

  static Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isConnected = connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.ethernet);

    if (!isConnected) {
      showSnackBarRed(AppStatic.internetErrorMsg);
    }

    return isConnected;
  }

  Future<void> apiCall({
    bool onResponseLoaderClose = false,
    required ApiType apiMethod,
    bool isLoaderNeeded = true,
    required String url,
    Map<String, dynamic>? data, // For JSON body
    Map<String, String>? body, // For form-data
    String? imagePath, // For single image
    List<String>? imageList, // For multiple images
    String? imageKey,
    bool isMockUrl = false,
    required Function(String message, dynamic data) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      if (isLoaderNeeded) {
        showLoadingDialog();
      }
      Get.focusScope?.unfocus();

      Map<String, dynamic> response = {};

      /// Decide API method
      switch (apiMethod) {
        case ApiType.get:
          response = await HttpHandler.getHttpMethod(url: url, isMockUrl: isMockUrl);
          break;

        case ApiType.post:
          response = await HttpHandler.postHttpMethod(url: url, data: data);
          break;

        case ApiType.put:
          response = await HttpHandler.putHttpMethod(url: url, data: data);
          break;

        case ApiType.delete:
          response = await HttpHandler.deleteHttpMethod(url: url, data: data);
          break;

        case ApiType.getForm:
          response = await HttpHandler.formDataMethod(
            url: url,
            body: body,
            apiMethod: "GET",
            imagePath: imagePath,
            imageList: imageList,
            imageKey: imageKey,
          );
          break;

        case ApiType.postForm:
          response = await HttpHandler.formDataMethod(
            url: url,
            body: body,
            apiMethod: "POST",
            imagePath: imagePath,
            imageList: imageList,
            imageKey: imageKey,
          );
          break;

        case ApiType.putForm:
          response = await HttpHandler.formDataMethod(
            url: url,
            body: body,
            apiMethod: "PUT",
            imagePath: imagePath,
            imageList: imageList,
            imageKey: imageKey,
          );
          break;

        case ApiType.deleteForm:
          response = await HttpHandler.formDataMethod(
            url: url,
            body: body,
            apiMethod: "DELETE",
            imagePath: imagePath,
            imageList: imageList,
            imageKey: imageKey,
          );
          break;
      }

      if (onResponseLoaderClose && isLoaderNeeded) {
        hideLoadingDialog();
      }

      /// Parse response
      dynamic responseBody = response['body'];
      if (responseBody is String) {
        responseBody = jsonDecode(responseBody);
      }

      if (responseBody['success'] == 1) {
        onSuccess(responseBody['message'], responseBody['data']);
      } else {
        String errorMessage = responseBody['message'] ?? "Something went wrong";
        showSnackBarRed(errorMessage);
        onError(errorMessage);
      }
    } catch (e) {
      showSnackBarRed(e.toString());
      onError(e.toString());
    } finally {
      if (!onResponseLoaderClose && isLoaderNeeded) {
        hideLoadingDialog();
      }
    }
  }
}
