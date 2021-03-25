import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';
import '../budget/BudgetTextField.dart';
import './BudgetDatePicker.dart';

class BudgetForm extends StatefulWidget {
  final Function addBudget;
  BudgetForm({@required this.addBudget});
  @override
  _BudgetFormState createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  final _title = TextEditingController();
  final _maxBudget = TextEditingController();
  String startDay;
  String lastDay;
  void submitData() {
    widget.addBudget(_title.text, int.tryParse(_maxBudget.text),startDay,lastDay);
    Navigator.pop(context);
  }

  void getStartDateTime(String date) {
    setState(() {
      startDay = date;
    });
  }

  void getLastDateTime(String date) {
    setState(() {
      lastDay = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNeutral450,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          child: Column(children: [
            Text(
              'Create New Budget',
              style: kHeadline2White,
            ),
            kSizedBoxVerticalM,
            BudgetTextField(
              title: 'Title',
              textEditingController: _title,
            ),
            kSizedBoxVerticalS,
            BudgetTextField(
              title: 'MaxBudget',
              textEditingController: _maxBudget,
            ),
            kSizedBoxVerticalS,
            BudgetDatePicker(
              title: 'Pick Start Date',
              getDateTime: getStartDateTime,
            ),
            kSizedBoxVerticalS,
            BudgetDatePicker(
              title: 'Pick End Date',
              getDateTime: getLastDateTime,
            ),
            kSizedBoxVerticalM,
            PrimaryButton(
                text: "Submit",
                onPressed: () {
                  submitData();
                }),
          ]),
        ),
      ),
    );
  }
}
