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
  void submitData(){
    widget.addBudget(_title,_maxBudget);
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
            ),
            kSizedBoxVerticalS,
            BudgetDatePicker(
              title: 'Pick End Date',
            ),
            kSizedBoxVerticalM,
            PrimaryButton(text: "Submit", onPressed: (){
              submitData();
            }),
          ]),
        ),
      ),
    );
  }
}
