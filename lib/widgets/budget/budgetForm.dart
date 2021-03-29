import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';
import 'budgetTextField.dart';
import 'budgetDatePicker.dart';

class BudgetForm extends StatefulWidget {
  final Function addBudget;
  BudgetForm({@required this.addBudget});
  @override
  _BudgetFormState createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  final _title = TextEditingController();
  final _maxBudget = TextEditingController();
  DateTime startDay;
  DateTime lastDay;
  void submitData() {
    widget.addBudget(
        _title.text, double.tryParse(_maxBudget.text), startDay, lastDay);
    Navigator.pop(context);
  }

  void getStartDateTime(DateTime date) {
    if (lastDay != null && date.isAfter(lastDay)) {
      return;
    }
    setState(() {
      startDay = date;
    });
  }

  void getLastDateTime(DateTime date) {
    if (startDay != null && date.isBefore(startDay)) {
      return;
    }
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
          child: Column(
            children: [
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
                dateTime: startDay,
              ),
              kSizedBoxVerticalS,
              BudgetDatePicker(
                title: 'Pick End Date',
                getDateTime: getLastDateTime,
                dateTime: lastDay,
              ),
              kSizedBoxVerticalM,
              PrimaryButton(
                text: "Submit",
                onPressed: () {
                  submitData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
