import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:setthi/config/api.dart';
import 'package:setthi/config/string.dart';
import 'package:setthi/model/httpException.dart';

class WalletItem {
  final int id;
  final String title;
  final double amount;
  WalletItem({
    @required this.id,
    @required this.title,
    @required this.amount,
  });
}

class WalletProvider with ChangeNotifier {
  String _token;
  List<WalletItem> _wallets;
  WalletProvider(this._token, this._wallets);

  List<WalletItem> get wallets {
    return _wallets ?? [];
  }

  double get totalAmount {
    double total = 0;
    _wallets.forEach((wallet) {
      total += wallet.amount;
    });
    return total;
  }

  bool isEmpty() {
    return _wallets.isEmpty;
  }

  int get walletCount {
    return _wallets.length;
  }

  Future<void> fetchWallet() async {
    try {
      final response = await Dio().get(apiEndpoint + '/wallets',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _wallets = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(internetException);
    }
  }

  Future<void> addWallet(String title, double amount) async {
    try {
      final response = await Dio().post(apiEndpoint + '/wallet',
          data: {"name": title, "amount": amount},
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _wallets = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      if (error.response.statusCode == 400)
        throw HttpException(overLimitException("wallets", 5));
      throw HttpException(internetException);
    }
  }

  Future<void> removeWallet(int id) async {
    try {
      final response = await Dio().delete(apiEndpoint + '/wallet/$id',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _wallets = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      if (error.response.statusCode == 400)
        throw HttpException(atleastException("wallet"));
      throw HttpException(internetException);
    }
  }

  Future<void> editWallet(int id, String title, double amount) async {
    try {
      final response = await Dio().patch(apiEndpoint + '/wallet/$id',
          data: {"name": title, "amount": amount},
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _wallets = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      if (error.response.statusCode == 400)
        throw HttpException(generalException);
      throw HttpException(internetException);
    }
  }

  List<WalletItem> modifyResponse(List<dynamic> data) {
    List<WalletItem> wallets = [];
    data.forEach((el) => wallets.add(WalletItem(
        id: el["id"], title: el["name"], amount: double.parse(el["amount"]))));
    return wallets;
  }
}
