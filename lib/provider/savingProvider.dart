import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:setthi/config/api.dart';
import 'package:setthi/config/string.dart';
import 'package:setthi/model/httpException.dart';

class Saving {
  final int id;
  final String title;
  final double currentAmount;
  final double targetAmount;
  final DateTime startDay;
  final DateTime endDay;
  Saving({
    @required this.id,
    @required this.title,
    @required this.currentAmount,
    @required this.targetAmount,
    this.startDay,
    this.endDay,
  });
  double get currentPercent {
    return this.currentAmount / this.targetAmount;
  }
}

class SavingProvider with ChangeNotifier {
  String _token;
  List<Saving> _saving = [];
  SavingProvider(this._token, this._saving);
  int get savingCount {
    return _saving.length;
  }

  List<Saving> get saving {
    return _saving;
  }

  Future<void> fetchSaving() async {
    try {
      final response = await Dio().get(apiEndpoint + '/savings',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _saving = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(internetException);
    }
  }

  Future<void> addSaving(String title, String targetAmount, DateTime startDay,
      DateTime lastDay) async {
    try {
      final response = await Dio().post(apiEndpoint + '/saving',
          data: {
            "title": title,
            "target_amount": double.parse(targetAmount),
            "start_date": dateTimetoDate(startDay),
            "end_date": dateTimetoDate(lastDay)
          },
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _saving = modifyResponse(response.data.toList());
      notifyListeners();
    }catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      if (error.response.statusCode == 400)
        throw HttpException(overLimitException("saving", 5));
      throw HttpException(internetException);
    }
  }

  Future<void> editSaving(int id, String title, String targetAmount) async {
    try {
      final response = await Dio().patch(apiEndpoint + '/saving/$id',
          data: {
            "title": title,
            "target_amount": double.parse(targetAmount),
          },
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _saving = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(internetException);
    }
  }

  Future<void> deleteSaving(int id) async {
    try {
      final response = await Dio().delete(apiEndpoint + '/saving/$id',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _saving = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      if (error.response.statusCode == 400)
        throw HttpException(atleastException("Saving"));
      throw HttpException(internetException);
    }
  }

  List<Saving> modifyResponse(List<dynamic> data) {
    List<Saving> wallets = [];
    data.forEach((el) => wallets.add(Saving(
        id: el["id"],
        title: el["title"],
        startDay: stringToDateTime(el["start_date"]),
        endDay: stringToDateTime(el["end_date"]),
        currentAmount: double.parse(el["current_amount"]),
        targetAmount: double.parse(el["target_amount"]))));
    return wallets;
  }

  String dateTimetoDate(DateTime dateTime) {
    return dateTime.toString().split(' ')[0];
  }

  DateTime stringToDateTime(String date) {
    var extractedDate =
        date.split('T')[0].split('-').map((e) => int.parse(e)).toList();
    return DateTime(extractedDate[0], extractedDate[1], extractedDate[2]);
  }
}
