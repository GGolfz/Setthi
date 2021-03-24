import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import '../budget/BudgetTextField.dart';

class BudgetForm extends StatefulWidget {
  @override
  _BudgetFormState createState() => _BudgetFormState();
}

class _BudgetFormState extends State<BudgetForm> {
  final _title = TextEditingController();
  final _maxBudget = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNeutral450,
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Column(children: [
          Text(
            'Create New Budget',
            style: kHeadline2White,
          ),
          kSizedBoxVerticalS,
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
        ]),
      ),
    );
  }
}
