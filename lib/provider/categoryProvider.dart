import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:setthi/config/api.dart';
import 'package:setthi/model/categoryType.dart';

class Category {
  int id;
  String name;
  CategoryType type;
  Color color;
  Category(this.id, this.name, this.type, this.color);

  String get stringType {
    return {
      CategoryType.Income: "Income",
      CategoryType.Expense: "Expense"
    }[this.type];
  }
}

class CategoryProvider with ChangeNotifier {
  String _token;
  List<Category> _categories;
  CategoryProvider(this._token, this._categories);
  List<Category> get categories {
    return this._categories;
  }

  int get categoryCount {
    return this._categories.length;
  }

  List<Category> getCategoriesByType(CategoryType type) {
    return this._categories.where((category) => category.type == type).toList();
  }

  CategoryType getCategoryType(String type) {
    return {
      "INCOME": CategoryType.Income,
      "EXPENSE": CategoryType.Expense
    }[type];
  }

  String getColorText(Color color) {
    return "${color.red.toString()}:${color.green.toString()}:${color.blue.toString()}:${color.alpha.toString()}";
  }

  Color getColorFromText(String colorText) {
    var colorVal = colorText.split(':').map((e) => int.parse(e)).toList();
    return Color.fromARGB(colorVal[3], colorVal[0], colorVal[1], colorVal[2]);
  }

  Future<void> fetchCategories() async {
    try {
      final response = await Dio().get(apiEndpoint + '/categories',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _categories = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> createCategory(String name, String type, Color color) async {
    try {
      final response = await Dio().post(apiEndpoint + '/category',
          data: {"name": name, "type": type, "color": getColorText(color)},
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _categories = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> editCategory(
      int id, String name, String type, Color color) async {
    try {
      final response = await Dio().patch(apiEndpoint + '/category/$id',
          data: {"name": name, "type": type, "color": getColorText(color)},
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _categories = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      final response = await Dio().delete(apiEndpoint + '/category/$id',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _categories = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<Category> modifyResponse(List<dynamic> data) {
    List<Category> labels = [];
    data.forEach((el) => labels.add(Category(el["id"], el["name"],
        getCategoryType(el["type"]), getColorFromText(el["color"]))));
    return labels;
  }
}
