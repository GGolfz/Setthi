import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/api.dart';
import '../config/string.dart';
import '../model/httpException.dart';

class Saving {
  final int id;
  final String title;
  final double currentAmount;
  final double targetAmount;
  final DateTime startDay;
  final DateTime endDay;
  final bool isFinish;
  Saving(
      {@required this.id,
      @required this.title,
      @required this.currentAmount,
      @required this.targetAmount,
      this.startDay,
      this.endDay,
      this.isFinish});
  double get currentPercent {
    return this.currentAmount > this.targetAmount
        ? 1
        : this.currentAmount / this.targetAmount;
  }

  bool get isUsed {
    return this.isFinish && this.currentAmount == 0;
  }
}

class SavingGroup {
  List<Saving> _inProcessSaving;
  List<Saving> _finishSaving;
  List<Saving> _usedSaving;
  SavingGroup(this._inProcessSaving, this._finishSaving, this._usedSaving);

  bool get isEmpty {
    return (this.inProcessCount + this.finishCount + this.usedCount) == 0;
  }

  int get inProcessCount {
    return this._inProcessSaving.length;
  }

  List<Saving> get inProcess {
    return this._inProcessSaving;
  }

  int get finishCount {
    return this._finishSaving.length;
  }

  List<Saving> get finish {
    return this._finishSaving;
  }

  int get usedCount {
    return this._usedSaving.length;
  }

  List<Saving> get used {
    return this._usedSaving;
  }

  static SavingGroup get empty {
    return SavingGroup([], [], []);
  }
}

class SavingProvider with ChangeNotifier {
  String _token;
  SavingGroup _saving;
  SavingProvider(this._token, this._saving);
  SavingGroup get saving {
    return this._saving;
  }

  Future<void> fetchSaving() async {
    try {
      final response = await Dio().get(apiEndpoint + '/savings',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _saving = modifyResponse(response.data);
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
      _saving = modifyResponse(response.data);
      notifyListeners();
    } catch (error) {
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
      _saving = modifyResponse(response.data);
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
      _saving = modifyResponse(response.data);
      notifyListeners();
    } catch (error) {
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      if (error.response.statusCode == 400)
        throw HttpException(atleastException("Saving"));
      throw HttpException(internetException);
    }
  }

  SavingGroup modifyResponse(dynamic data) {
    return SavingGroup(
        modifySavingList(data["un_finished"].toList()),
        modifySavingList(data["finished_unused"].toList()),
        modifySavingList(data["finished_used"].toList()));
  }

  List<Saving> modifySavingList(List<dynamic> data) {
    List<Saving> saving = [];
    data.forEach((el) => saving.add(Saving(
        id: el["id"],
        title: el["title"],
        startDay: stringToDateTime(el["start_date"]),
        endDay: stringToDateTime(el["end_date"]),
        currentAmount: double.parse(el["current_amount"]),
        targetAmount: double.parse(el["target_amount"]),
        isFinish: el["is_finish"])));
    return saving;
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
