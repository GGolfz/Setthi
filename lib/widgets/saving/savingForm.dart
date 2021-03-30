import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';
import 'budgetTextField.dart';
import 'budgetDatePicker.dart';

class SavingForm extends StatefulWidget {
  final Function addBudget;
  SavingForm({@required this.addBudget});
  @override
  _SavingFormState createState() => _SavingFormState();
}

class _SavingFormState extends State<SavingForm> {
  final _title = TextEditingController();
  final _maxBudget = TextEditingController();
  DateTime startDay;
  DateTime lastDay;
  void submitData() {
    if (_title.text != null &&
        _maxBudget.text != null &&
        startDay != null &&
        lastDay != null) {
      widget.addBudget(
          _title.text, double.tryParse(_maxBudget.text), startDay, lastDay);
      Navigator.pop(context);
    }
  }

  Widget _buildContainerText(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(color: kNeutral400),
      ),
    );
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
      height: 410,
      width: 400,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Create New Budget',
                style: TextStyle(color: kGold500, fontSize: 20),
                textAlign: TextAlign.center,
              )
            ]),
            kSizedBoxVerticalS,
            BudgetTextField(
              title: 'Title',
              textEditingController: _title,
            ),
            kSizedBoxVerticalS,
            BudgetTextField(
              title: 'Target Amount',
              textEditingController: _maxBudget,
            ),
            kSizedBoxVerticalS,
            _buildContainerText('Start Date'),
            kSizedBoxVerticalXXS,
            BudgetDatePicker(
              title: 'Pick Start Date',
              getDateTime: getStartDateTime,
              dateTime: startDay,
            ),
            kSizedBoxVerticalS,
            _buildContainerText('End Date'),
            kSizedBoxVerticalXXS,
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
    );
  }
}
