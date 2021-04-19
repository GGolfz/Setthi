import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/api.dart';
import '../config/string.dart';
import '../model/httpException.dart';
import '../model/transactionType.dart';
import '../provider/categoryProvider.dart';
import '../provider/savingProvider.dart';
import '../utils/format.dart';
import '../widgets/transaction/sourceList.dart';

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
  List<TransactionItem> _transactions;
  List<TransactionItem> _allTransactions;
  TransactionProvider(this._token, this._transactions, this._allTransactions);
  List<TransactionItem> get transactions {
    return this._transactions;
  }

  List<TransactionItem> get allTransactions {
    return this._allTransactions;
  }

  String dateTimetoDate(DateTime dateTime) {
    return dateTime.toString().split(' ')[0];
  }

  Future<void> createTransaction({
    @required String title,
    @required double amount,
    @required TransactionType transactionType,
    @required SourceItem selectedSource,
    @required Category category,
    @required DateTime dateTime,
    Saving saving,
  }) async {
    try {
      var response;
      var baseData = {
        "title": title,
        "amount": amount,
        "date": dateTimetoDate(dateTime),
        "category_id": category.id,
        "wallet_id": selectedSource.id,
      };
      var options = Options(headers: {"Authorization": "Bearer " + _token});
      switch (transactionType) {
        case TransactionType.Income:
          response = await Dio().post(apiEndpoint + '/transaction/income',
              data: baseData, options: options);
          break;
        case TransactionType.Expense:
        case TransactionType.ExpenseFromSaving:
          if (selectedSource.sourceType == SourceType.wallet) {
            response = await Dio().post(apiEndpoint + '/transaction/expense',
                data: baseData, options: options);
          } else {
            response = await Dio().post(
                apiEndpoint + '/transaction/expense-saving',
                data: baseData,
                options: options);
          }
          break;
        case TransactionType.Saving:
          var data = {...baseData, "saving_id": saving.id};
          response = await Dio().post(apiEndpoint + '/transaction/saving',
              data: data, options: options);
          break;
      }
      _transactions = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 400) {
        if (transactionType == TransactionType.Expense &&
            selectedSource.sourceType == SourceType.saving)
          throw HttpException("The amount is does not match the saving amount");
        if (transactionType == TransactionType.Saving)
          throw HttpException(
              "The amount is more than needed to fullfilled the saving");
      }
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
    }
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
      _transactions = modifyResponse(response.data);
      notifyListeners();
    } on DioError catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(internetException);
    }
  }

  Future<void> fetchAllTransactions() async {
    try {
      final response = await Dio().get(apiEndpoint + '/transactions',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _allTransactions = modifyResponse(response.data);
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(internetException);
    }
  }

  Future<void> fetchAllTransactionByDate(DateTime dateTime) async {
    try {
      final response = await Dio().get(
          apiEndpoint + '/transactions?date=${dateTime.toString()}',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _allTransactions = modifyResponse(response.data);
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(internetException);
    }
  }

  Future<void> fetchAllTransactionBySearch(String search) async {
    try {
      final response = await Dio().get(
          apiEndpoint + '/transactions/search?term=$search',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _allTransactions = modifyResponse(response.data);
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(internetException);
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
          wallet: type == TransactionType.ExpenseFromSaving
              ? el["saving"]["name"]
              : el["wallet"]["name"],
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
