import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:setthi/config/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticateProvider with ChangeNotifier {
  String _token;
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
    } catch (error) {
      prefs.clear();
      // Should throw exception to warn user
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
    }
    // Call api again to check
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
