import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/model/formType.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/form/customDropDown.dart';
import 'package:setthi/widgets/form/customFormTitle.dart';
import 'package:setthi/widgets/form/customTextField.dart';

class LabelForm extends StatefulWidget {
  final FormType type;
  final String labelKey;
  LabelForm({@required this.type, this.labelKey});
  @override
  _LabelFormState createState() => _LabelFormState();
}

class _LabelFormState extends State<LabelForm> {
  final TextEditingController _label = TextEditingController();
  var _labelType = "Income";
  String _getFormTitle() {
    if (widget.type == FormType.Create) {
      return "Create New Label";
    }
    if (widget.type == FormType.Edit) {
      return "Edit Label";
    }
    return "";
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
          CustomTextField(title: "Label", textEditingController: _label),
          kSizedBoxVerticalS,
          CustomDropDown(
              title: "Type",
              currentValue: _labelType,
              items: ["Income", "Expense"],
              onChanged: (value) {
                setState(() {
                  _labelType = value;
                });
              }),
          kSizedBoxVerticalM,
          _getButton(),
        ])));
  }
}
