import 'package:flutter/foundation.dart';

class WalletItem {
  final String id;
  final String title;
  final double amount;
  WalletItem({
    @required this.id,
    @required this.title,
    @required this.amount,
  });
}

class WalletProvider with ChangeNotifier {
  WalletProvider();
  // List<WalletItem> _walltes = [];
  List<WalletItem> _wallets = [
    WalletItem(id: '1', title: 'wallet 1', amount: 5000),
    WalletItem(id: '2', title: 'wallet 2', amount: 300),
    WalletItem(id: '3', title: 'wallet 3', amount: 2900),
    WalletItem(id: '4', title: 'wallet 4', amount: 1000),
    WalletItem(id: '5', title: 'wallet 5', amount: 500)
  ];

  List<WalletItem> get wallets {
    return _wallets;
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

  Future<void> addWallet(String id, String title, double amount) async {
    _wallets.add(WalletItem(id: id, title: title, amount: amount));
    notifyListeners();
  }

  Future<void> removeWallet(String id) async {
    _wallets.remove((el) => id == el.id);
    notifyListeners();
  }

  Future<void> editWallet(String id, String tital, double amount) async {
    notifyListeners();
  }
}
