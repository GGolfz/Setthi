import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../buttons/actionButton.dart';
import '../form/customDropDown.dart';
import '../form/customFormTitle.dart';
import '../form/customTextField.dart';
import '../layout/errorDialog.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../model/formType.dart';
import '../../model/httpException.dart';
import '../../provider/labelProvider.dart';

class LabelForm extends StatefulWidget {
  final FormType type;
  final String labelText;
  final String labelType;
  final int labelKey;
  LabelForm(
      {@required this.type, this.labelKey, this.labelText, this.labelType});
  @override
  _LabelFormState createState() => _LabelFormState();
}

class _LabelFormState extends State<LabelForm> {
  TextEditingController _label;
  var _labelType;
  var _formKey = GlobalKey<FormState>();
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
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            try {
              await Provider.of<LabelProvider>(context, listen: false)
                  .createLabel(_label.text, _labelType);
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
                await Provider.of<LabelProvider>(context, listen: false)
                    .deleteLabel(widget.labelKey);
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
                  await Provider.of<LabelProvider>(context, listen: false)
                      .editLabel(widget.labelKey, _label.text, _labelType);
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
  void initState() {
    _label = TextEditingController(text: widget.labelText ?? "");
    _labelType = widget.labelType ?? "Income";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 280,
        width: 400,
        child: Form(
            key: _formKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
