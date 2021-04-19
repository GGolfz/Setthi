import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/string.dart';
import '../buttons/actionButton.dart';
import '../form/customDatePicker.dart';
import '../form/customFormTitle.dart';
import '../form/customTextField.dart';
import '../layout/errorDialog.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../model/httpException.dart';
import '../../provider/savingProvider.dart';

class SavingForm extends StatefulWidget {
  @override
  _SavingFormState createState() => _SavingFormState();
}

class _SavingFormState extends State<SavingForm> {
  final _title = TextEditingController();
  final _maxBudget = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  DateTime startDay;
  DateTime lastDay;
  void submitData() async {
    if (_formKey.currentState.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await Provider.of<SavingProvider>(context, listen: false)
            .addSaving(_title.text, _maxBudget.text, startDay, lastDay);
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
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
    return Container(
      height: max(MediaQuery.of(context).size.height * 0.5, 415),
      width: MediaQuery.of(context).size.width * 0.8,
      child: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomFormTitle(title: createBudgetText),
            kSizedBoxVerticalS,
            CustomTextField(
              title: 'Title',
              textEditingController: _title,
            ),
            kSizedBoxVerticalS,
            CustomTextField(
              title: 'Target Amount',
              textEditingController: _maxBudget,
              keyboardType: TextInputType.number,
            ),
            kSizedBoxVerticalS,
            CustomDatePicker(
              title: 'Start Date',
              getDateTime: getStartDateTime,
              dateTime: startDay,
            ),
            kSizedBoxVerticalS,
            CustomDatePicker(
              title: 'End Date',
              getDateTime: getLastDateTime,
              dateTime: lastDay,
            ),
            kSizedBoxVerticalM,
            ActionButton(
              text: "Submit",
              color: kGold300,
              isLoading: isLoading,
              onPressed: () => submitData(),
            ),
          ],
        ),
      )),
    );
  }
}
