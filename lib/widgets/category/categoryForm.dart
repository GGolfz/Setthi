import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/model/formType.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/form/customDropDown.dart';
import 'package:setthi/widgets/form/customFormTitle.dart';
import 'package:setthi/widgets/form/customTextField.dart';

class CategoryForm extends StatefulWidget {
  final FormType type;
  final String labelKey;
  CategoryForm({@required this.type, this.labelKey});
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final TextEditingController _category = TextEditingController();
  var _categoryType = "Income";
  Color pickerColor = kRed100;
  Color currentColor = kRed100;
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
        onPressed: () {},
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
            onPressed: () {},
          )),
          kSizedBoxHorizontalS,
          Expanded(
              child: ActionButton(
            text: "Submit",
            color: kGold300,
            onPressed: () {},
          ))
        ],
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 260,
        width: 400,
        child: Form(
            child: Column(children: [
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
          kSizedBoxVerticalS,
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
