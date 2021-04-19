import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/api.dart';
import '../config/string.dart';
import '../model/labelType.dart';
import '../model/httpException.dart';

class Label {
  int id;
  String name;
  LabelType type;
  Label(this.id, this.name, this.type);

  String get stringType {
    return {
      LabelType.Income: "Income",
      LabelType.Expense: "Expense"
    }[this.type];
  }
}

class LabelProvider with ChangeNotifier {
  String _token;
  List<Label> _labels;
  LabelProvider(this._token, this._labels);
  List<Label> get labels {
    return this._labels;
  }

  int get labelCount {
    return this._labels.length;
  }

  List<Label> getLabelByType(LabelType type) {
    return this._labels.where((label) => label.type == type).toList();
  }

  Future<void> fetchLabels() async {
    try {
      final response = await Dio().get(apiEndpoint + '/labels',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _labels = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
    }
  }

  LabelType getLabelType(String type) {
    return {"INCOME": LabelType.Income, "EXPENSE": LabelType.Expense}[type];
  }

  Future<void> createLabel(String name, String type) async {
    try {
      final response = await Dio().post(apiEndpoint + '/label',
          data: {"name": name, "type": type.toUpperCase()},
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _labels = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 400)
        throw HttpException(overLimitException('On Each Label', 10));
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
    }
  }

  Future<void> editLabel(int id, String name, String type) async {
    try {
      final response = await Dio().patch(apiEndpoint + '/label/$id',
          data: {"name": name, "type": type.toUpperCase()},
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _labels = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
    }
  }

  Future<void> deleteLabel(int id) async {
    try {
      final response = await Dio().delete(apiEndpoint + '/label/$id',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _labels = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      if (error.response.statusCode == 400)
        throw HttpException(atleastException("Label"));
      throw HttpException(generalException);
    }
  }

  List<Label> modifyResponse(List<dynamic> data) {
    List<Label> labels = [];
    data.forEach((el) =>
        labels.add(Label(el["id"], el["label"], getLabelType(el["type"]))));
    return labels;
  }
}
