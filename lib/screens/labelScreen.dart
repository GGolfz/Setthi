import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/model/labelStatus.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/label/labelItem.dart';
import 'package:setthi/widgets/label/labelTypeSelect.dart';
import 'package:setthi/widgets/layout/appBar.dart';
import 'package:setthi/widgets/layout/divider.dart';

class LabelScreen extends StatefulWidget {
  static const routeName = '/label';

  @override
  _LabelScreenState createState() => _LabelScreenState();
}

class _LabelScreenState extends State<LabelScreen> {
  var _status = LabelStatus.Income;
  void _changeStatus(LabelStatus status) {
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SetthiAppBar(
          title: 'Label',
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
                    LabelTypeSelect(
                        text: "Income Label",
                        type: LabelStatus.Income,
                        changeStatus: _changeStatus,
                        current: _status),
                    LabelTypeSelect(
                        text: "Expense Label",
                        type: LabelStatus.Expense,
                        changeStatus: _changeStatus,
                        current: _status),
                  ],
                ),
              ),
              kSizedBoxVerticalS,
              Container(
                height: 560,
                child: ListView.separated(
                    itemBuilder: (ctx, index) => LabelItem(
                          labelText:
                              "${_status == LabelStatus.Income ? "Income" : "Expense"} Label Text $index",
                        ),
                    separatorBuilder: (ctx, index) => CustomDivider(),
                    itemCount: 10),
              ),
              kSizedBoxVerticalS,
              Container(
                  width: 220,
                  child: ActionButton(
                    text: "Create a new label",
                    onPressed: () {},
                  ))
            ],
          ),
        ));
  }
}
