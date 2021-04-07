import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/model/formType.dart';
import 'package:setthi/model/httpException.dart';
import 'package:setthi/provider/categoryProvider.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/form/customDropDown.dart';
import 'package:setthi/widgets/form/customFormTitle.dart';
import 'package:setthi/widgets/form/customTextField.dart';
import '../layout/errorDialog.dart';

class CategoryForm extends StatefulWidget {
  final FormType type;
  final int labelKey;
  final String name;
  final String categoryType;
  final Color color;
  CategoryForm(
      {@required this.type,
      this.labelKey,
      this.name,
      this.categoryType,
      this.color});
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  TextEditingController _category;
  var _categoryType;
  Color pickerColor;
  Color currentColor;
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _category = TextEditingController(text: widget.name ?? '');
    _categoryType = widget.categoryType ?? "Income";
    currentColor = widget.color ?? kRed100;
    pickerColor = currentColor;
    super.initState();
  }

  String _getFormTitle() {
    if (widget.type == FormType.Create) {
      return "Create New Category";
    }
    if (widget.type == FormType.Edit) {
      return "Edit Category";
    }
    return "";
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Widget _getButton() {
    if (widget.type == FormType.Create) {
      return ActionButton(
        text: "Submit",
        color: kGold300,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            try {
              await Provider.of<CategoryProvider>(context, listen: false)
                  .createCategory(_category.text, _categoryType, currentColor);
              Navigator.of(context).pop();
            } on HttpException catch (error) {
              showErrorDialog(
                  context: context,
                  text: error.message,
                  isNetwork: error.isInternetProblem);
            }
          }
        },
      );
    }
    if (widget.type == FormType.Edit) {
      return Row(
        children: [
          Expanded(
              child: ActionButton(
            text: "Delete",
            color: kRed400,
            isOutlined: true,
            onPressed: () async {
              try {
                await Provider.of<CategoryProvider>(context, listen: false)
                    .deleteCategory(widget.labelKey);
                Navigator.of(context).pop();
              } on HttpException catch (error) {
                showErrorDialog(
                    context: context,
                    text: error.message,
                    isNetwork: error.isInternetProblem);
              }
            },
          )),
          kSizedBoxHorizontalS,
          Expanded(
              child: ActionButton(
            text: "Submit",
            color: kGold300,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                try {
                  await Provider.of<CategoryProvider>(context, listen: false)
                      .editCategory(
                          widget.labelKey, _category.text, currentColor);
                  Navigator.of(context).pop();
                } on HttpException catch (error) {
                  showErrorDialog(
                      context: context,
                      text: error.message,
                      isNetwork: error.isInternetProblem);
                }
              }
            },
          ))
        ],
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.type == FormType.Create ? 280 : 200,
        width: 400,
        child: Form(
            key: _formKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              CustomFormTitle(title: _getFormTitle()),
              kSizedBoxVerticalS,
              Row(
                children: [
                  GestureDetector(
                    child: Container(
                      width: kSizeM,
                      height: kSizeM,
                      decoration: BoxDecoration(
                          borderRadius: kBorderRadiusXS, color: currentColor),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                            content: Container(
                          height: 400,
                          child: Column(children: [
                            ColorPicker(
                              pickerColor: pickerColor,
                              onColorChanged: changeColor,
                              showLabel: false,
                              pickerAreaHeightPercent: 0.8,
                            ),
                            ActionButton(
                              text: "Select",
                              color: kGold300,
                              onPressed: () {
                                setState(() => currentColor = pickerColor);
                                Navigator.of(context).pop();
                              },
                            )
                          ]),
                        )),
                      );
                    },
                  ),
                  kSizedBoxHorizontalS,
                  Flexible(
                      child: CustomTextField(
                          title: "Label", textEditingController: _category))
                ],
              ),
              if (widget.type == FormType.Create) kSizedBoxVerticalS,
              if (widget.type == FormType.Create)
                CustomDropDown(
                    title: "Type",
                    currentValue: _categoryType,
                    items: ["Income", "Expense"],
                    onChanged: (value) {
                      setState(() {
                        _categoryType = value;
                      });
                    }),
              kSizedBoxVerticalM,
              _getButton(),
            ])));
  }
}
