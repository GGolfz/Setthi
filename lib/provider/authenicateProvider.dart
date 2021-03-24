import 'package:flutter/foundation.dart';

class AuthenticateProvider with ChangeNotifier {
  String _token;
  AuthenticateProvider();
  bool get isAuth {
    return _token != null;
  }

  Future<void> login(String email, String password) async {
    _token = "THIS IS MOCKUP TOKEN";
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _token = "THIS IS MOCKUP TOKEN";
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
  }
}
