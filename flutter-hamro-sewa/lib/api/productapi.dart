import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:najikkopasal/api/httpServices.dart';
import 'package:najikkopasal/model/create_order_model.dart';
import 'package:najikkopasal/response/order_response.dart';
import 'package:najikkopasal/response/product_response.dart';
import 'package:najikkopasal/utils/url.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductAPI {
  Future<ProductResponse?> getproduct(
      {String? keywords = "", String? category = ""}) async {
    ProductResponse? productResponse;
    Response? response;
    // Box box;
    // var dir = await getApplicationDocumentsDirectory();
    // Hive.init(dir.path);
    // box = await Hive.openBox('mybox');
    // var stored = box.get("data");

    // var encoded = jsonDecode(stored);

    // productResponse = ProductResponse.fromJson(encoded);

    try {
      var dio = HttpServices().getDioInstance();

      var url = baseUrl + productUrl;

      if (category != "") {
        response = await dio.get(url,
            queryParameters: {'category': category, 'keyword': keywords});
      } else {
        response = await dio.get(url, queryParameters: {'keyword': keywords});
      }

      if (response.statusCode == 200) {
        productResponse = ProductResponse.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return productResponse;
  }

  Future<ProductResponse?> getproducts() async {
    ProductResponse? productResponse;
    Response? response;
    Box box;
    var dir = await getApplicationDocumentsDirectory();

    Hive.init(dir.path);
    box = await Hive.openBox('mybox');
    var stored = box.get("data");

    var encoded = jsonDecode(stored);

    productResponse = ProductResponse.fromJson(encoded);
    try {
      var dio = HttpServices().getDioInstance();

      var url = baseUrl + productUrl;

      response = await dio.get(
        url,
      );
      String postdata = jsonEncode(response.data);

      if (response.statusCode == 200) {
        String postdata = jsonEncode(response.data);

        box.put("data", postdata);

        productResponse = ProductResponse.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return productResponse;
  }

// give product review
  Future<bool> giveproductreview(
      String productId, String comment, int rating) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userlogintoken = sharedPreferences.getString('token');

    bool isReview = false;

    try {
      var url = baseUrl + reviewUrl;

      var dio = HttpServices().getDioInstance();

      var response = await dio.put(url,
          data: {"productId": productId, "comment": comment, "rating": rating},
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $userlogintoken"
          }));

      if (response.statusCode == 200) {
        isReview = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isReview;
  }

  Future<bool> postOrder(Autogenerated auto) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userlogintoken = sharedPreferences.getString('token');

    bool isReview = false;

    try {
      var url = baseUrl + reviewUrl;

      var dio = HttpServices().getDioInstance();

      var response = await dio.put(url,
          data: auto.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $userlogintoken"
          }));

      if (response.statusCode == 200) {
        isReview = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isReview;
  }

  Future<OrderResponse?> getOrderHistory() async {
    OrderResponse? orderResponse;
    try {
      var url = baseUrl + myOrderUrl;
      var dio = HttpServices().getDioInstance();
      SharedPreferences preferences;
      preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      var response = await dio.get(url,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"}));
      if (response.statusCode == 200) {
        orderResponse = OrderResponse.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return orderResponse!;
  }
}
