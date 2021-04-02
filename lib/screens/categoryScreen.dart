import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/model/CategoryType.dart';
import 'package:setthi/model/formType.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/category/categoryForm.dart';
import 'package:setthi/widgets/category/categoryItem.dart';
import 'package:setthi/widgets/category/categoryTypeSelect.dart';
import 'package:setthi/widgets/layout/appBar.dart';
import 'package:setthi/widgets/layout/customDialog.dart';
import 'package:setthi/widgets/layout/divider.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = '/category';

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var _status = CategoryType.Income;
  void _changeStatus(CategoryType status) {
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
        resizeToAvoidBottomInset: false,
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
                        type: CategoryType.Income,
                        changeStatus: _changeStatus,
                        current: _status),
                    CategoryTypeSelect(
                        text: "Expense Category",
                        type: CategoryType.Expense,
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
                              "${_status == CategoryType.Income ? "Income" : "Expense"} Category Text $index",
                          onTap: () {
                            showCustomDialog(
                                context: context,
                                content: CategoryForm(
                                  type: FormType.Edit,
                                  labelKey: index.toString(),
                                ));
                          },
                        ),
                    separatorBuilder: (ctx, index) => CustomDivider(),
                    itemCount: 10),
              ),
              kSizedBoxVerticalS,
              Container(
                  width: 220,
                  child: ActionButton(
                    text: "Create a new category",
                    onPressed: () {
                      showCustomDialog(
                          context: context,
                          content: CategoryForm(
                            type: FormType.Create,
                          ));
                    },
                  ))
            ],
          ),
        ));
  }
}
