import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:setthi/config/api.dart';
import 'package:setthi/model/labelType.dart';

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
      print(error);
    }
  }

  LabelType getLabelType(String type) {
    return {"INCOME": LabelType.Income, "EXPENSE": LabelType.Expense}[type];
  }

  Future<void> createLabel(String name, String type) async {
    try {
      final response = await Dio().post(apiEndpoint + '/label',
          data: {"name": name, "type": type},
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _labels = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> editLabel(int id, String name, String type) async {
    try {
      final response = await Dio().patch(apiEndpoint + '/label/$id',
          data: {"name": name, "type": type},
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _labels = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteLabel(int id) async {
    try {
      final response = await Dio().delete(apiEndpoint + '/label/$id',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _labels = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<Label> modifyResponse(List<dynamic> data) {
    List<Label> labels = [];
    data.forEach((el) =>
        labels.add(Label(el["id"], el["label"], getLabelType(el["type"]))));
    return labels;
  }
}
