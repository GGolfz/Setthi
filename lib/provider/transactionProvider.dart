import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:setthi/config/api.dart';
import 'package:setthi/model/transactionType.dart';
import 'package:setthi/utils/format.dart';
import 'package:setthi/widgets/transaction/transactionTypeItem.dart';


class TransactionItem {
  int id;
  String name;
  TransactionType type;
  double amount;
  DateTime date;
  String wallet;
  Color color;
  TransactionItem(
      {this.id,
      this.name,
      this.type,
      this.amount,
      this.date,
      this.wallet,
      this.color});

  String get stringType {
    return {
      TransactionType.Income: "Income",
      TransactionType.Expense: "Expense",
      TransactionType.Saving: "Saving",
      TransactionType.ExpenseFromSaving: "Expense_from_saving"
    }[this.type];
  }
}

class TransactionProvider with ChangeNotifier {
  String _token;
  List<TransactionItem> _transaction;
  TransactionProvider(this._token, this._transaction);
  List<TransactionItem> get transactions {
    return this._transaction;
  }

  TransactionType getTransactionType(String type) {
    return {
      "INCOME": TransactionType.Income,
      "EXPENSE": TransactionType.Expense,
      "SAVING": TransactionType.Saving,
      "EXPENSE_FROM_SAVING": TransactionType.ExpenseFromSaving,
    }[type];
  }

  Future<void> fetchTransaction() async {
    try {
      final response = await Dio().get(apiEndpoint + '/timeline',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      print(response.data);
      _transaction = modifyResponse(response.data);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<TransactionItem> modifyResponse(List<dynamic> data) {
    List<TransactionItem> transactions = [];
    data.forEach((el) {
      TransactionType type = getTransactionType(el["transaction_type"]);
      transactions.add(TransactionItem(
          id: el["id"],
          name: el["title"],
          type: type,
          amount: double.parse(el["amount"]),
          date: stringToDateTime(el["date"]),
          wallet: type==TransactionType.ExpenseFromSaving ? el["saving"]["name"]:el["wallet"]["name"],
          color: getColorFromText(el["category"]["color"])));
    });
    return transactions;
  }

  DateTime stringToDateTime(String date) {
    var extractedDate =
        date.split('T')[0].split('-').map((e) => int.parse(e)).toList();
    return DateTime(extractedDate[0], extractedDate[1], extractedDate[2]);
  }
}
