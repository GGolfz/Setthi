import 'package:flutter/material.dart';
import 'package:setthi/model/categoryType.dart';

class Category {
  String name;
  String color;
  CategoryType type;
}

class CategoryProvider with ChangeNotifier {
  final String _token;
  final List<Category> _categories;
  CategoryProvider(this._token, this._categories);
  List<Category> get categories {
    return this._categories;
  }

  int get categoryCount {
    return this._categories.length;
  }

  Future<void> fetchCategories() async {}
}
