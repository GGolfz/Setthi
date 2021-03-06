import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../config/api.dart';
import '../config/string.dart';
import '../model/httpException.dart';
import '../utils/format.dart';

class WalletItem {
  final int id;
  final String title;
  final double amount;
  WalletItem({
    @required this.id,
    @required this.title,
    @required this.amount,
  });
  static WalletItem get defaultWallet {
    return WalletItem(id: 0, title: '', amount: 0);
  }
}

class ChartDataPoint {
  String date;
  double amount;
  ChartDataPoint(this.date, this.amount);
}

class ChartData {
  double max;
  List<ChartDataPoint> income;
  List<ChartDataPoint> expense;
  ChartData(this.max, this.income, this.expense);
  static get empty {
    DateTime today = DateTime.now();
    List<ChartDataPoint> data = [];
    for (var i = 0; i < 7; i++) {
      data.add(ChartDataPoint(getWeekDayString(today.weekday), 0));
      today.add(Duration(days: 1));
    }
    return ChartData(0, data, data);
  }
}

class CategoryChartDataItem {
  int id;
  String name;
  Color color;
  int count;
  double max;
  CategoryChartDataItem(this.id, this.name, this.color, this.count, this.max);
  double get amount {
    return count.toDouble();
  }

  double get percent {
    return count / max;
  }

  String get label {
    return (percent * 100).toStringAsFixed(2);
  }
}

class CategoryChartDataItemEach {
  int max;
  List<CategoryChartDataItem> data;
  CategoryChartDataItemEach(this.max, this.data);
  static get empty {
    return CategoryChartDataItemEach(0, []);
  }
}

class CategoryChartData {
  CategoryChartDataItemEach income;
  CategoryChartDataItemEach expense;
  CategoryChartData(this.income, this.expense);
  static get empty {
    return CategoryChartData(
        CategoryChartDataItemEach.empty, CategoryChartDataItemEach.empty);
  }
}

class WalletProvider with ChangeNotifier {
  String _token;
  List<WalletItem> _wallets;
  ChartData _chartData;
  CategoryChartData _categoryChartData;
  WalletProvider(
      this._token, this._wallets, this._chartData, this._categoryChartData);

  List<WalletItem> get wallets {
    return _wallets ?? [];
  }

  ChartData get chartData {
    return _chartData ?? ChartData.empty;
  }

  CategoryChartData get categoryData {
    return _categoryChartData ?? CategoryChartData.empty;
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

  Future<void> fetchExpenseChart() async {
    try {
      final response = await Dio().get(apiEndpoint + '/expense-graph',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _chartData = modifyTransationChartResponse(
          max(response.data["income"]["top"].toDouble(),
              response.data["expense"]["top"].toDouble()),
          response.data["income"]["data"].toList(),
          response.data["expense"]["data"].toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
    }
  }

  Future<void> fetchCategoryChart() async {
    try {
      final response = await Dio().get(apiEndpoint + '/category-graph',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _categoryChartData = modifyCategoryChartResponse(
          response.data["income"], response.data["expense"]);
      notifyListeners();
    } on DioError catch (error) {
      print(error);
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
    }
  }

  ChartData modifyTransationChartResponse(
      double top, List<dynamic> income, List<dynamic> expense) {
    List<ChartDataPoint> incomeDataPoint = [];
    List<ChartDataPoint> expenseDataPoint = [];
    income.forEach((el) => incomeDataPoint
        .add(ChartDataPoint(el["date"], el["amount"].toDouble())));
    expense.forEach((el) => expenseDataPoint
        .add(ChartDataPoint(el["date"], el["amount"].toDouble())));
    return ChartData(top, incomeDataPoint, expenseDataPoint);
  }

  CategoryChartData modifyCategoryChartResponse(Map income, Map expense) {
    List<CategoryChartDataItem> incomeData = [];
    List<CategoryChartDataItem> expenseData = [];
    income["data"].entries.forEach((entry) => incomeData.add(
        CategoryChartDataItem(
            int.tryParse(entry.key),
            entry.value["name"],
            getColorFromText(entry.value["color"]),
            entry.value["count"],
            income["count"].toDouble())));
    expense["data"].entries.forEach((entry) => expenseData.add(
        CategoryChartDataItem(
            int.tryParse(entry.key),
            entry.value["name"],
            getColorFromText(entry.value["color"]),
            entry.value["count"],
            expense["count"].toDouble())));
    return CategoryChartData(
        CategoryChartDataItemEach(income["count"], incomeData),
        CategoryChartDataItemEach(expense["count"], expenseData));
  }

  Future<void> fetchWallet() async {
    try {
      final response = await Dio().get(apiEndpoint + '/wallets',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _wallets = modifyResponse(response.data.toList());
      notifyListeners();
    } on DioError catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
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
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      if (error.response.statusCode == 400)
        throw HttpException(overLimitException("wallets", 5));
      throw HttpException(generalException);
    }
  }

  Future<void> removeWallet(int id) async {
    try {
      final response = await Dio().delete(apiEndpoint + '/wallet/$id',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _wallets = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      if (error.response.statusCode == 400)
        throw HttpException(atleastException("wallet"));
      throw HttpException(generalException);
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
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      if (error.response.statusCode == 400)
        throw HttpException(generalException);
      throw HttpException(generalException);
    }
  }

  List<WalletItem> modifyResponse(List<dynamic> data) {
    List<WalletItem> wallets = [];
    data.forEach((el) => wallets.add(WalletItem(
        id: el["id"], title: el["name"], amount: double.parse(el["amount"]))));
    return wallets;
  }
}
