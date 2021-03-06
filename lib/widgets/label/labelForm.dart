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
  var isLoading = false;
  var isLoadingEdit = false;
  var isLoadingDelete = false;
  String _getFormTitle() {
    if (widget.type == FormType.Create) {
      return "Create New Prefilled Title";
    }
    if (widget.type == FormType.Edit) {
      return "Edit Prefilled Title";
    }
    return "";
  }

  Widget _getButton() {
    if (widget.type == FormType.Create) {
      return ActionButton(
        text: "Submit",
        color: kGold300,
        isLoading: isLoading,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            try {
              setState(() {
                isLoading = true;
              });
              await Provider.of<LabelProvider>(context, listen: false)
                  .createLabel(_label.text, _labelType);
              setState(() {
                isLoading = false;
              });
              Navigator.of(context).pop();
            } on HttpException catch (error) {
              showErrorDialog(
                  context: context,
                  text: error.message,
                  isNetwork: error.isInternetProblem);
              setState(() {
                isLoading = false;
              });
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
            isLoading: isLoadingDelete,
            color: kRed400,
            isOutlined: true,
            onPressed: () async {
              try {
                setState(() {
                  isLoadingDelete = true;
                });
                await Provider.of<LabelProvider>(context, listen: false)
                    .deleteLabel(widget.labelKey);
                setState(() {
                  isLoadingDelete = false;
                });
                Navigator.of(context).pop();
              } on HttpException catch (error) {
                showErrorDialog(
                    context: context,
                    text: error.message,
                    isNetwork: error.isInternetProblem);
                setState(() {
                  isLoadingDelete = false;
                });
              }
            },
          )),
          kSizedBoxHorizontalS,
          Expanded(
              child: ActionButton(
            text: "Submit",
            color: kGold300,
            isLoading: isLoadingEdit,
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                try {
                  setState(() {
                    isLoadingEdit = true;
                  });
                  await Provider.of<LabelProvider>(context, listen: false)
                      .editLabel(widget.labelKey, _label.text, _labelType);
                  setState(() {
                    isLoadingEdit = false;
                  });
                  Navigator.of(context).pop();
                } on HttpException catch (error) {
                  showErrorDialog(
                      context: context,
                      text: error.message,
                      isNetwork: error.isInternetProblem);
                  setState(() {
                    isLoadingEdit = false;
                  });
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
              CustomTextField(
                  title: "Prefilled Title", textEditingController: _label),
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
