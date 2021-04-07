import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/model/http_exception.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/form/customDatePicker.dart';
import 'package:setthi/widgets/form/customFormTitle.dart';
import 'package:setthi/widgets/form/customTextField.dart';
import '../../provider/savingProvider.dart';
import '../../widgets/layout/errorDialog.dart';

class SavingForm extends StatefulWidget {
  @override
  _SavingFormState createState() => _SavingFormState();
}

class _SavingFormState extends State<SavingForm> {
  final _title = TextEditingController();
  final _maxBudget = TextEditingController();
  DateTime startDay;
  DateTime lastDay;
  void submitData() async {
    if (_title.text != null &&
        _maxBudget.text != null &&
        startDay != null &&
        lastDay != null) {
      try {
        await Provider.of<SavingProvider>(context, listen: false)
            .addSaving(_title.text, _maxBudget.text, startDay, lastDay);
        Navigator.pop(context);
      } on HttpException catch (error) {
        print('This');
        print(error);
        showErrorDialog(context: context, text: error.message);
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
      height: 415,
      width: 400,
      child: Form(
        child: Column(
          children: [
            CustomFormTitle(title: 'Create New Budget'),
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
              onPressed: ()=>submitData(),
            ),
          ],
        ),
      ),
    );
  }
}
