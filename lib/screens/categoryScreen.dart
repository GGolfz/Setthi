import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/model/categoryStatus.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/category/categoryItem.dart';
import 'package:setthi/widgets/category/categoryTypeSelect.dart';
import 'package:setthi/widgets/layout/appBar.dart';
import 'package:setthi/widgets/layout/divider.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var _status = CategoryStatus.Income;
  void _changeStatus(CategoryStatus status) {
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SetthiAppBar(
          title: 'Category',
          leading: BackButton(),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeXS),
          child: Column(
            children: [
              Container(
                height: 40,
                child: Row(
                  children: [
                    CategoryTypeSelect(
                        text: "Income Category",
                        type: CategoryStatus.Income,
                        changeStatus: _changeStatus,
                        current: _status),
                    CategoryTypeSelect(
                        text: "Expense Category",
                        type: CategoryStatus.Expense,
                        changeStatus: _changeStatus,
                        current: _status),
                  ],
                ),
              ),
              kSizedBoxVerticalS,
              Container(
                height: 560,
                child: ListView.separated(
                    itemBuilder: (ctx, index) => CategoryItem(
                          categoryText:
                              "${_status == CategoryStatus.Income ? "Income" : "Expense"} Category Text $index",
                        ),
                    separatorBuilder: (ctx, index) => CustomDivider(),
                    itemCount: 10),
              ),
              kSizedBoxVerticalS,
              Container(
                  width: 220,
                  child: ActionButton(
                    text: "Create a new category",
                    onPressed: () {},
                  ))
            ],
          ),
        ));
  }
}
