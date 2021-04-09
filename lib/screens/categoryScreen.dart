import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../model/categoryType.dart';
import '../model/formType.dart';
import '../provider/categoryProvider.dart';
import '../widgets/buttons/actionButton.dart';
import '../widgets/category/categoryForm.dart';
import '../widgets/category/categoryItem.dart';
import '../widgets/category/categoryTypeSelect.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/layout/customDialog.dart';
import '../widgets/layout/divider.dart';

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
                child:
                    Consumer<CategoryProvider>(builder: (ctx, categories, _) {
                  final categoriesList =
                      categories.getCategoriesByType(_status);
                  return ListView.separated(
                      itemBuilder: (ctx, index) => CategoryItem(
                            categoryText: categoriesList[index].name,
                            categoryColor: categoriesList[index].color,
                            onTap: () {
                              showCustomDialog(
                                  context: context,
                                  content: CategoryForm(
                                    type: FormType.Edit,
                                    labelKey: categoriesList[index].id,
                                    name: categoriesList[index].name,
                                    color: categoriesList[index].color,
                                    categoryType:
                                        categoriesList[index].stringType,
                                  ));
                            },
                          ),
                      separatorBuilder: (ctx, index) => CustomDivider(),
                      itemCount: categoriesList.length);
                }),
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
