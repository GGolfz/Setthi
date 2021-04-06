import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:setthi/config/api.dart';
import 'package:setthi/model/http_exception.dart';

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
    }catch (error) {
      throw HttpException("Your Internet doesn't connect");
    }
  }

  Future<void> addWallet(String title, double amount) async {
    try {
      final response = await Dio().post(apiEndpoint + '/wallet',
          data: {"name": title, "amount": amount},
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _wallets = modifyResponse(response.data.toList());
      notifyListeners();
    }on DioError catch (error) {
      if(error.response == null){
        throw HttpException("Internet connection was bad");
      }else if(error.response.statusCode == 400){
      throw HttpException("Your can't Create more than 5 Wallet .");
      }else{
        throw HttpException("SomeThing Error");
      }
    }
  }

  Future<void> removeWallet(int id) async {
    try {
      final response = await Dio().delete(apiEndpoint + '/wallet/$id',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _wallets = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      throw HttpException("Your Internet was bad. Please Try again .");
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
      throw HttpException("Your Internet was bad. Please try Again .");
    }
  }

  List<WalletItem> modifyResponse(List<dynamic> data) {
    List<WalletItem> wallets = [];
    data.forEach((el) => wallets.add(WalletItem(
        id: el["id"], title: el["name"], amount: double.parse(el["amount"]))));
    return wallets;
  }
}
