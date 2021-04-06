import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:setthi/config/api.dart';
import 'package:setthi/model/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticateProvider with ChangeNotifier {
  String _token;
  String _recoveryToken;

  AuthenticateProvider();
  bool get isAuth {
    return _token != null;
  }

  String get token {
    return _token;
  }

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await Dio().post(apiEndpoint + '/auth/signin',
          data: {"email": email, "password": password});
      final token = response.data["token"];
      _token = token;
      Timer(Duration(milliseconds: 500), () => notifyListeners());
      prefs.setString('userToken', _token);
    } on DioError catch (error) {
      prefs.clear();
      if(error.response == null){
      throw HttpException('Your Connection was Bad');
      }else if(error.response.statusCode == 401){
        throw HttpException('Your email or password is wrong');
      }else{
        throw HttpException("Something was worng");
      }
    }
  }

  Future<void> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await Dio().post(apiEndpoint + '/auth/regis',
          data: {"email": email, "password": password});
      final token = response.data["token"];
      _token = token;
      Timer(Duration(milliseconds: 500), () => notifyListeners());
      prefs.setString('userToken', _token);
    } catch (error) {
      prefs.clear();
      throw HttpException('Email Already Used');
      // Should to exception to warn user
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) return false;
    final token = prefs.getString('userToken');
    _token = token;
    notifyListeners();
    try {
      await Dio().get(apiEndpoint + '/auth/user',
          options: Options(headers: {"Authorization": "Bearer " + token}));
    } catch (error) {
      prefs.clear();
      _token = null;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> forgetPassword(String email) async {
    try {
      await Dio().post(apiEndpoint + '/auth/reset', data: {"email": email});
      Timer(Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {
      throw HttpException('Invalid email');
    }
  }

  Future<void> checkResetPassword(String recoveryToken) async {
    try {
      _recoveryToken = recoveryToken;
      await Dio().post(apiEndpoint + '/auth/check-token',
          data: {"token": recoveryToken});
      Timer(Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {}
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await Dio().patch(apiEndpoint + '/auth/reset',
          data: {"token": _recoveryToken, "password": newPassword});
      Timer(Duration(milliseconds: 500), () => notifyListeners());
    } catch (error) {}
  }
}
