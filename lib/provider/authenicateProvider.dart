import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticateProvider with ChangeNotifier {
  String _token;
  AuthenticateProvider();
  bool get isAuth {
    return _token != null;
  }

  Future<void> login(String email, String password) async {
    _token = "THIS IS MOCKUP TOKEN";
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', _token);
  }

  Future<void> register(String email, String password) async {
    _token = "THIS IS MOCKUP TOKEN";
    Timer(Duration(milliseconds: 500), () {
      notifyListeners();
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', _token);
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) return false;
    final token = prefs.getString('userToken');
    _token = token;
    notifyListeners();
    // Call api again to check
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs..clear();
  }
}
