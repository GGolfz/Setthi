import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/api.dart';
import '../model/categoryType.dart';
import '../config/string.dart';
import '../model/httpException.dart';
import '../utils/format.dart';

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

  Future<void> fetchCategories() async {
    try {
      final response = await Dio().get(apiEndpoint + '/categories',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _categories = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
    }
  }

  Future<void> createCategory(String name, String type, Color color) async {
    try {
      final response = await Dio().post(apiEndpoint + '/category',
          data: {
            "name": name,
            "type": type.toUpperCase(),
            "color": getColorText(color)
          },
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _categories = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 400)
        throw HttpException(overLimitException('On Each Category', 10));
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
    }
  }

  Future<void> editCategory(int id, String name, Color color) async {
    try {
      final response = await Dio().patch(apiEndpoint + '/category/$id',
          data: {"name": name, "color": getColorText(color)},
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _categories = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      final response = await Dio().delete(apiEndpoint + '/category/$id',
          options: Options(headers: {"Authorization": "Bearer " + _token}));
      _categories = modifyResponse(response.data.toList());
      notifyListeners();
    } catch (error) {
      if (error.response == null) throw HttpException(internetException);
      if (error.response.statusCode == 401)
        throw HttpException(authenticateException);
      throw HttpException(generalException);
    }
  }

  List<Category> modifyResponse(List<dynamic> data) {
    List<Category> labels = [];
    data.forEach((el) => labels.add(Category(el["id"], el["name"],
        getCategoryType(el["type"]), getColorFromText(el["color"]))));
    return labels;
  }
}
