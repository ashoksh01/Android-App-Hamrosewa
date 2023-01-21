import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:najikkopasal/api/httpServices.dart';
import 'package:najikkopasal/response/login.dart';
import 'package:najikkopasal/response/profile_response.dart';

// import 'package:najikkopasal/utils/sessionmanager.dart';
import 'package:najikkopasal/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserAPI {
  Future<bool> registerUser(User user) async {
    try {
      var url = baseUrl + registerUrl;
      var dio = HttpServices().getDioInstance();

      var formData = FormData.fromMap({
        "name": user.name,
        "email": user.email,
        "password": user.password,
       
      });

      var response = await dio.post(url, data: formData);
      if (response.statusCode == 201) {
        return true;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        Fluttertoast.showToast(
            msg: e.response!.data['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP_LEFT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Color.fromARGB(255, 205, 22, 22),
            fontSize: 30.0);
      }
    }

    return false;
  }

// User login Function
  Future<bool> login(String email, String password) async {
    bool isLogin = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      var url = baseUrl + loginUrl;
      var dio = HttpServices().getDioInstance();
      var response =
          await dio.post(url, data: {"email": email, "password": password});

      if (response.statusCode == 200) {
        String name = jsonEncode(response.data['user']['name']);
        String name1 = jsonDecode(name);
        sharedPreferences.setString("name", name1);
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);

        token = loginResponse.token;

        sharedPreferences.setString('token', '$token');

        isLogin = true;
      }
    } on DioError catch (e) {
      print(e.toString());
    }

    return isLogin;
  }

  Future<ProfileResponse?> fetchUserfromapi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userlogintoken = sharedPreferences.getString('token');
    ProfileResponse? profileResponse;
    Response? response;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + fetchfromapiUrl;

      response = await dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $userlogintoken"
          }));

      if (response.statusCode == 200) {
        profileResponse = ProfileResponse.fromJson(response.data);
      }
    } catch (e) {
      print(e.toString());
    }
    return profileResponse;
  }

// update profile Function
  Future<bool> updateprofile(String? name, String? email, String? image) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userlogintoken = sharedPreferences.getString('token');

    bool isprofileUpdated = false;

    try {
      var url = baseUrl + updateprofileUrl;

      var dio = HttpServices().getDioInstance();
      var formData =
          FormData.fromMap({"name": name, "email": email, "avatar": image});

      var response = await dio.put(url,
          data: formData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $userlogintoken"
          }));

      if (response.statusCode == 200) {
        print("Profile  update bhyaooooooooooooooooooooo");

        isprofileUpdated = true;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        Fluttertoast.showToast(
            msg: e.response!.data['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP_LEFT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Color.fromARGB(255, 205, 22, 22),
            fontSize: 30.0);
      }
    }

    return isprofileUpdated;
  }

  Future<bool> chnagePassword(
      String? oldPassword, String? newPassword, String? confirmPassword) async {
    bool chnagePassword = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? changeptoken = sharedPreferences.getString('token');

    try {
      var url = baseUrl + changePasswordUrl;

      var dio = HttpServices().getDioInstance();

      var response = await dio.put(url,
          data: {
            "oldPassword": oldPassword,
            "newPassword": newPassword,
            "confirmPassword": confirmPassword
          },
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $changeptoken"
          }));

      if (response.statusCode == 200) {
        chnagePassword = true;
        // get data from sessionmanager class

      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print(e.toString());
      }
    }

    return chnagePassword;
  }
}



// create the class which take user object and convert to JsonEncoder


